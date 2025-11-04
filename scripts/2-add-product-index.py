#!/usr/bin/env python3
"""
Add Products to Azure AI Search Index for Zava Product Catalog

This script updates an Azure AI Search index with additional products from a CSV file,
generating vector embeddings for semantic search capabilities.

Usage:
    python add-product-index.py [--data-file path/to/add-products.csv] [--max-products N] [--skip-rbac]

Environment Variables Required:
    AZURE_AI_SEARCH_ENDPOINT - Azure AI Search service endpoint
    AZURE_OPENAI_ENDPOINT - Azure OpenAI service endpoint
    AZURE_AI_EMBED_DEPLOYMENT_NAME - Azure OpenAI embedding model deployment name
    
Environment Variables Optional:
    AZURE_AISEARCH_INDEX - Search index name (default: "zava-products")
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path
from typing import List, Dict

import pandas as pd
from azure.identity import DefaultAzureCredential, get_bearer_token_provider
from azure.search.documents import SearchClient
from azure.search.documents.indexes import SearchIndexClient
from azure.search.documents.indexes.models import (
    HnswParameters,
    HnswAlgorithmConfiguration,
    SemanticPrioritizedFields,
    SearchableField,
    SearchField,
    SearchFieldDataType,
    SearchIndex,
    SemanticSearch,
    SemanticConfiguration,
    SemanticField,
    SimpleField,
    VectorSearch,
    VectorSearchAlgorithmKind,
    VectorSearchAlgorithmMetric,
    ExhaustiveKnnAlgorithmConfiguration,
    ExhaustiveKnnParameters,
    VectorSearchProfile,
)
from openai import AzureOpenAI
from dotenv import load_dotenv


def find_repo_root():
    """Find the repository root by looking for .git directory or specific files."""
    current_path = Path.cwd()
    
    # Look for repository indicators
    while current_path != current_path.parent:
        if (current_path / ".git").exists() or (current_path / "README.md").exists():
            return current_path
        current_path = current_path.parent
    
    # If not found, use current directory
    return Path.cwd()


def load_environment():
    """Load environment variables from .env file, looking in repo root first."""
    repo_root = find_repo_root()
    
    # Try to load .env from repo root first
    env_file = repo_root / ".env"
    if env_file.exists():
        load_dotenv(env_file)
        print(f"✓ Loaded environment from: {env_file}")
    else:
        # Fallback to default load_dotenv behavior
        load_dotenv()
        print("Using environment variables from system/default locations")


def resolve_data_file_path(data_file_arg):
    """Resolve data file path relative to script directory or repository structure."""
    # Get the directory where this script is located
    script_dir = Path(__file__).parent
    
    # If it's an absolute path, use as-is
    if Path(data_file_arg).is_absolute():
        return data_file_arg
    
    # First, try relative to the script directory (where CSV should be in customization/)
    script_relative = script_dir / "customization" / data_file_arg
    if script_relative.exists():
        return str(script_relative)
    
    # Try relative to script directory directly
    script_direct = script_dir / data_file_arg
    if script_direct.exists():
        return str(script_direct)
    
    # If file exists relative to current working directory, use that
    if Path(data_file_arg).exists():
        return data_file_arg
    
    # Try relative to repository root as fallback
    repo_root = find_repo_root()
    root_relative = repo_root / data_file_arg
    if root_relative.exists():
        return str(root_relative)
    
    # Return original path (let error handling in gen_zava_products handle it)
    return data_file_arg


def check_environment_variables():
    """Check that required environment variables are set."""
    required_vars = ["AZURE_AI_SEARCH_ENDPOINT", "AZURE_OPENAI_ENDPOINT", "AZURE_AI_EMBED_DEPLOYMENT_NAME"]
    missing_vars = []
    
    for var in required_vars:
        if not os.environ.get(var):
            missing_vars.append(var)
    
    if missing_vars:
        print(f"Error: Missing required environment variables: {', '.join(missing_vars)}")
        print("Please set these variables in your .env file or environment.")
        sys.exit(1)
    
    # Set default index name if not provided
    if not os.environ.get("AZURE_AISEARCH_INDEX"):
        os.environ["AZURE_AISEARCH_INDEX"] = "zava-products"
        print(f"Using default index name: zava-products")


def check_azure_login():
    """Check if user is logged into Azure CLI."""
    try:
        result = subprocess.run(
            ["az", "account", "show"], 
            capture_output=True, 
            text=True, 
            check=True
        )
        print("✓ Azure CLI authentication verified")
        return True
    except subprocess.CalledProcessError:
        print("Error: You are not logged into Azure.")
        print("Please run 'az login' first to authenticate with Azure.")
        sys.exit(1)
    except FileNotFoundError:
        print("Error: Azure CLI not found.")
        print("Please install Azure CLI first: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli")
        sys.exit(1)


def run_rbac_update():
    """Run the RBAC update script to ensure proper permissions."""
    # Get the directory where this script is located
    script_dir = Path(__file__).parent
    
    # RBAC script should be in the same directory
    rbac_script = script_dir / "2-add-products-rbac.sh"
    
    if not rbac_script.exists():
        print(f"Warning: RBAC script not found at: {rbac_script}")
        print("Please ensure you have the proper Azure permissions set up.")
        print("You may need to run the RBAC script manually.")
        return
    
    print("Running RBAC update script to ensure proper permissions...")
    try:
        result = subprocess.run(
            ["bash", str(rbac_script)],
            cwd=script_dir,  # Run from the script's directory
            capture_output=True,
            text=True,
            check=True
        )
        print("✓ RBAC update completed successfully.")
        if result.stdout:
            print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error running RBAC update script: {e}")
        if e.stdout:
            print(f"stdout: {e.stdout}")
        if e.stderr:
            print(f"stderr: {e.stderr}")
        print("Continuing anyway, but you may encounter permission issues...")


def delete_index(search_index_client: SearchIndexClient, search_index: str):
    """Delete existing index if it exists."""
    try:
        print(f"Deleting existing index {search_index}...")
        search_index_client.delete_index(search_index)
        print(f"Index {search_index} deleted successfully")
    except Exception as e:
        print(f"No existing index to delete (this is normal): {e}")


def create_index_definition(name: str) -> SearchIndex:
    """
    Returns an Azure AI Search index with the given name.
    """
    # The fields we want to index. The "contentVector" field is a vector field that will
    # be used for vector search.
    fields = [
        SimpleField(name="id", type=SearchFieldDataType.String, key=True),
        SearchableField(name="content", type=SearchFieldDataType.String),
        SimpleField(name="filepath", type=SearchFieldDataType.String),
        SearchableField(name="title", type=SearchFieldDataType.String),
        SimpleField(name="url", type=SearchFieldDataType.String),
        SimpleField(name="price", type=SearchFieldDataType.Double, filterable=True, sortable=True),
        SimpleField(name="stock", type=SearchFieldDataType.Int32, filterable=True, sortable=True),
        SearchField(
            name="contentVector",
            type=SearchFieldDataType.Collection(SearchFieldDataType.Single),
            searchable=True,
            # Size of the vector created by the text-embedding-3-large model.
            vector_search_dimensions=3072,
            vector_search_profile_name="myHnswProfile",
        ),
    ]

    # The "content" field should be prioritized for semantic ranking.
    semantic_config = SemanticConfiguration(
        name="default",
        prioritized_fields=SemanticPrioritizedFields(
            title_field=SemanticField(field_name="title"),
            keywords_fields=[],
            content_fields=[SemanticField(field_name="content")],
        ),
    )

    # For vector search, we want to use the HNSW (Hierarchical Navigable Small World)
    # algorithm (a type of approximate nearest neighbor search algorithm) with cosine
    # distance.
    vector_search = VectorSearch(
        algorithms=[
            HnswAlgorithmConfiguration(
                name="myHnsw",
                kind=VectorSearchAlgorithmKind.HNSW,
                parameters=HnswParameters(
                    m=4,
                    ef_construction=400,
                    ef_search=500,
                    metric=VectorSearchAlgorithmMetric.COSINE,
                ),
            ),
            ExhaustiveKnnAlgorithmConfiguration(
                name="myExhaustiveKnn",
                kind=VectorSearchAlgorithmKind.EXHAUSTIVE_KNN,
                parameters=ExhaustiveKnnParameters(
                    metric=VectorSearchAlgorithmMetric.COSINE
                ),
            ),
        ],
        profiles=[
            VectorSearchProfile(
                name="myHnswProfile",
                algorithm_configuration_name="myHnsw",
            ),
            VectorSearchProfile(
                name="myExhaustiveKnnProfile",
                algorithm_configuration_name="myExhaustiveKnn",
            ),
        ],
    )

    # Create the semantic settings with the configuration
    semantic_search = SemanticSearch(configurations=[semantic_config])

    # Create the search index.
    index = SearchIndex(
        name=name,
        fields=fields,
        semantic_search=semantic_search,
        vector_search=vector_search,
    )

    return index


def gen_zava_products(
    path: str,
    n: int = None,
) -> List[Dict[str, any]]:
    """
    Process Zava product catalog and generate embeddings for each product.
    
    Args:
        path: Path to the products.csv file
        n: Number of products to process (if None, process all products)
        
    Returns:
        List of product documents ready for indexing
    """
    openai_service_endpoint = os.environ["AZURE_OPENAI_ENDPOINT"]
    openai_deployment = os.environ["AZURE_AI_EMBED_DEPLOYMENT_NAME"]

    token_provider = get_bearer_token_provider(
        DefaultAzureCredential(), 
        "https://cognitiveservices.azure.com/.default"
    )
    
    # Initialize Azure OpenAI client
    client = AzureOpenAI(
        api_version="2025-02-01-preview",
        azure_endpoint=openai_service_endpoint,
        azure_deployment=openai_deployment,
        azure_ad_token_provider=token_provider
    )

    # Load Zava product catalog
    print(f"Loading product catalog from: {path}")
    if not os.path.exists(path):
        print(f"Error: Product catalog file not found: {path}")
        sys.exit(1)
        
    products = pd.read_csv(path)
    
    # Limit to first n products if specified
    if n is not None:
        products = products.head(n)
        print(f"Processing first {len(products)} products from catalog")
    else:
        print(f"Processing all {len(products)} products from catalog")
    
    items = []
    
    for i, product in enumerate(products.to_dict("records"), 1):
        print(f"Processing product {i}/{len(products)}: {product['name']}")
        
        # Use description as the main content for embedding
        content = product["description"]
        # Use SKU as the unique identifier
        id = str(product["sku"])
        title = product["name"]
        # Create URL based on product name and SKU
        url = f"/products/{product['sku'].lower()}"
        
        # Generate embedding for the product description
        emb = client.embeddings.create(input=content, model=openai_deployment)
        
        # Create search document
        rec = {
            "id": id,
            "content": content,
            "filepath": f"{product['sku'].lower()}",
            "title": title,
            "url": url,
            "price": float(product["price"]),
            "stock": int(product["stock_level"]),
            "contentVector": emb.data[0].embedding,
        }
        items.append(rec)

    return items


def main():
    """Main function to set up the Azure AI Search index."""
    parser = argparse.ArgumentParser(
        description="Add Products to Azure AI Search Index for Zava Product Catalog"
    )
    parser.add_argument(
        "--data-file",
        default="add-products.csv",
        help="Path to the product catalog CSV file (default: add-products.csv in customization/ directory)"
    )
    parser.add_argument(
        "--max-products",
        type=int,
        default=None,
        help="Maximum number of products to process (default: process all)"
    )
    parser.add_argument(
        "--skip-rbac",
        action="store_true",
        help="Skip running the RBAC update script"
    )
    
    args = parser.parse_args()
    
    print("=" * 70)
    print("Add Products to Azure AI Search Index")
    print("=" * 70)
    
    # Load environment variables (looks for .env in repo root)
    load_environment()
    
    # Check required environment variables
    check_environment_variables()
    
    # Check Azure CLI authentication
    check_azure_login()
    
    # Resolve data file path relative to script directory
    resolved_data_file = resolve_data_file_path(args.data_file)
    
    # Run RBAC update script unless skipped
    if not args.skip_rbac:
        run_rbac_update()
    else:
        print("⊘ Skipping RBAC update (--skip-rbac flag set)")
    
    # Get configuration from environment
    search_endpoint = os.environ["AZURE_AI_SEARCH_ENDPOINT"]
    index_name = os.environ["AZURE_AISEARCH_INDEX"]
    
    print(f"\nConfiguration:")
    print(f"  Index name: {index_name}")
    print(f"  Search endpoint: {search_endpoint}")
    print(f"  Data file: {resolved_data_file}")
    if args.max_products:
        print(f"  Max products: {args.max_products}")
    print()
    
    # Initialize search index client
    search_index_client = SearchIndexClient(
        search_endpoint, DefaultAzureCredential()
    )
    
    # Delete existing index if it exists (recreating from scratch)
    delete_index(search_index_client, index_name)
    
    # Create new index with defined schema
    index = create_index_definition(index_name)
    print(f"Creating index '{index_name}'...")
    search_index_client.create_or_update_index(index)
    print(f"✓ Index '{index_name}' created successfully\n")
    
    # Process Zava product catalog and generate embeddings
    print(f"Processing product catalog and generating embeddings...")
    docs = gen_zava_products(resolved_data_file, n=args.max_products)
    
    # Initialize search client for document upload
    search_client = SearchClient(
        endpoint=search_endpoint,
        index_name=index_name,
        credential=DefaultAzureCredential(),
    )
    
    # Upload all product documents to the index
    print(f"\nUploading {len(docs)} products to index '{index_name}'...")
    ds = search_client.upload_documents(docs)
    print(f"✓ Successfully uploaded {len(docs)} products to the search index!")
    print(f"\nThe product catalog is now ready for semantic search.")
    print("=" * 70)


if __name__ == "__main__":
    main()