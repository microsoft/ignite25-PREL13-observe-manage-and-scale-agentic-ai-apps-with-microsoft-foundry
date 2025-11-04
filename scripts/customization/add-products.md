# Add Products to Azure AI Search Index

This script creates an Azure AI Search index and populates it with products from a CSV file. The script handles RBAC permissions, index creation, embedding generation, and data upload in one streamlined process.

## What This Script Does

1. Verifies Azure CLI authentication
2. Loads environment configuration from `.env` file
3. Runs the RBAC update script to ensure proper Azure permissions (optional)
4. Creates an Azure AI Search index with vector search capabilities
5. Processes products from the CSV file
6. Generates embeddings for each product using Azure OpenAI
7. Uploads the products to the search index

## Files

- **`../2-add-product-index.py`** - Main Python script (in scripts/ directory)
- **`../2-add-products-rbac.sh`** - Bash script to configure Azure RBAC permissions (in scripts/ directory)
- **`add-products.csv`** - CSV file containing products to add to the index (in customization/ directory)
- **`add-products.md`** - This documentation file

## Prerequisites

### Authentication
- **Azure CLI Login** - You must be logged into Azure using `az login`

### Azure Services Required
- **Azure AI Search Service** - for indexing and searching products
- **Azure OpenAI Service** - for generating text embeddings

### Models Required
- **`text-embedding-3-large`** (or compatible embedding model) - deployed in your Azure OpenAI service

### Environment Variables Required

Create a `.env` file in the repository root with these variables:

```bash
# Azure AI Search
AZURE_AI_SEARCH_ENDPOINT=https://your-search-service.search.windows.net

# Azure OpenAI
AZURE_OPENAI_ENDPOINT=https://your-openai-service.openai.azure.com
AZURE_AI_EMBED_DEPLOYMENT_NAME=text-embedding-3-large

# Azure Resource Group (for RBAC)
AZURE_RESOURCE_GROUP=your-resource-group-name
```

### Optional Environment Variables
- `AZURE_AISEARCH_INDEX` - Search index name (default: "zava-products")

## Installation

Install required Python packages:

```bash
pip install pandas azure-identity azure-search-documents openai python-dotenv
```

## Usage

### Before Running the Script

Ensure you are authenticated with Azure:
```bash
az login
```

### Basic Usage

Run the script from the `scripts/` directory:

```bash
cd scripts
python 2-add-product-index.py
```

By default, the script will:
- Use `customization/add-products.csv` relative to the script location
- Process all products in the file
- Run the RBAC update script first
- Create/recreate the `zava-products` index

### Advanced Usage

```bash
# Use a different data file (absolute path)
python 2-add-product-index.py --data-file /path/to/other-products.csv

# Use a different data file (relative to scripts/ dir)
python 2-add-product-index.py --data-file customization/add-products.csv

# Process only the first 20 products (useful for testing)
python 2-add-product-index.py --max-products 20

# Skip the RBAC update (if permissions are already set)
python 2-add-product-index.py --skip-rbac

# Combine options
python 2-add-product-index.py --data-file customization/custom.csv --max-products 50 --skip-rbac
```

### Get Help

```bash
python 2-add-product-index.py --help
```

## Running Components Separately

### Update RBAC Permissions Only

If you just need to update permissions without running the full script:

```bash
cd scripts
bash 2-add-products-rbac.sh
```

The RBAC script assigns three roles:
- **Search Index Data Contributor** - Full access to search index data
- **Search Index Data Reader** - Read access to search index data  
- **Cognitive Services OpenAI User** - Access to OpenAI embeddings

## CSV File Format

The `add-products.csv` file should have these columns:

```csv
name,sku,price,description,stock_level,image_path,main_category,subcategory
```

Example:
```csv
Professional Claw Hammer 16oz,HTHM001600,28,"High-quality steel claw hammer",25,image.png,HAND TOOLS,HAMMERS
```

Required columns: `name`, `sku`, `price`, `description`, `stock_level`

## Error Handling

The script provides comprehensive error checking and will:

- ✓ Verify Azure CLI authentication before proceeding
- ✓ Check for required environment variables
- ✓ Verify the data file exists
- ✓ Provide detailed progress information during execution
- ✓ Use Azure DefaultAzureCredential for secure authentication

### Common Issues

**"You are not logged into Azure"**
- Solution: Run `az login` to authenticate with Azure CLI

**"Missing required environment variables"**
- Solution: Create a `.env` file in the repository root with the required variables (see Prerequisites section)

**"DeploymentNotFound" error**
- Solution: Ensure your embedding model is deployed in your Azure OpenAI service
- Verify the deployment name in `AZURE_AI_EMBED_DEPLOYMENT_NAME` matches exactly
- Check that the deployment is active and available in your region

**"Product catalog file not found"**
- Solution: Ensure `add-products.csv` exists in the `scripts/customization` directory
- Or specify the correct path with `--data-file` parameter (e.g., `--data-file customization/add-products.csv`)

**Permission denied errors**
- Solution: Run the RBAC script: `bash ../2-add-products-rbac.sh` (from customization/ dir) or `bash 2-add-products-rbac.sh` (from scripts/ dir)
- Or run the main script without `--skip-rbac` flag

## Expected Output

When successful, the script will display:

```
======================================================================
Add Products to Azure AI Search Index
======================================================================
✓ Loaded environment from: /path/to/.env
✓ Azure CLI authentication verified

Running RBAC update script to ensure proper permissions...
======================================================================
Update RBAC Permissions for Azure AI Search Index
======================================================================
✓ Azure login confirmed.
...
✓ RBAC permissions updated successfully
======================================================================

Configuration:
  Index name: zava-products
  Search endpoint: https://your-search.search.windows.net
  Data file: /path/to/add-products.csv

Creating index 'zava-products'...
✓ Index 'zava-products' created successfully

Processing product catalog and generating embeddings...
Loading product catalog from: /path/to/add-products.csv
Processing all 424 products from catalog
Processing product 1/424: Professional Claw Hammer 16oz
Processing product 2/424: Ball Peen Hammer 12oz
...

Uploading 424 products to index 'zava-products'...
✓ Successfully uploaded 424 products to the search index!

The product catalog is now ready for semantic search.
======================================================================
```

## Next Steps

After successfully running this script:

1. **Test the search index** - Use Azure Portal or SDK to query the index
2. **Integrate with applications** - Reference the index in your applications using the index name (default: `zava-products`)
3. **Monitor usage** - Check Azure Portal for search metrics and performance

## Troubleshooting

For additional help:
- Check Azure Portal for service health
- Verify all Azure services are in the same region
- Review Azure Monitor logs for detailed error messages
- Ensure your Azure subscription has sufficient quota
