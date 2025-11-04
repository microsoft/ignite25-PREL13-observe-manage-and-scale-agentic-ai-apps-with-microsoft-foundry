#!/bin/bash
# ============================================================================
# Script: 00-get-env-skillable-fixed.sh
# Description: Fixed version with better error handling and diagnostics
# ============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$WORKSPACE_ROOT/.env"

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}Environment Update Script (Fixed)${NC}"
echo -e "${BLUE}======================================${NC}\n"

# ============================================================================
# Step 1: Get Resource Group
# ============================================================================
echo -e "${YELLOW}Step 1: Determining resource group...${NC}"

if [ -z "$AZURE_RESOURCE_GROUP" ]; then
    echo -e "${YELLOW}AZURE_RESOURCE_GROUP not set in environment${NC}"
    read -p "Enter your Azure Resource Group name: " AZURE_RESOURCE_GROUP
fi

if [ -z "$AZURE_RESOURCE_GROUP" ]; then
    echo -e "${RED}Error: Resource group name is required${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Using resource group: $AZURE_RESOURCE_GROUP${NC}\n"

# ============================================================================
# Step 2: Verify Azure CLI login
# ============================================================================
echo -e "${YELLOW}Step 2: Verifying Azure CLI authentication...${NC}"

if ! az account show &>/dev/null; then
    echo -e "${RED}Error: Not logged in to Azure CLI${NC}"
    echo -e "Please run: ${BLUE}az login${NC}"
    exit 1
fi

AZURE_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
AZURE_TENANT_ID=$(az account show --query tenantId -o tsv)
SUBSCRIPTION_NAME=$(az account show --query name -o tsv)

echo -e "${GREEN}✓ Azure CLI authenticated${NC}"
echo -e "  Subscription: $SUBSCRIPTION_NAME"
echo -e "  Subscription ID: $AZURE_SUBSCRIPTION_ID\n"

# ============================================================================
# Step 3: Verify Resource Group exists
# ============================================================================
echo -e "${YELLOW}Step 3: Verifying resource group exists...${NC}"

AZURE_LOCATION=$(az group show --name "$AZURE_RESOURCE_GROUP" --query location -o tsv 2>/dev/null || echo "")

if [ -z "$AZURE_LOCATION" ]; then
    echo -e "${RED}Error: Resource group '$AZURE_RESOURCE_GROUP' not found${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Resource group found: $AZURE_RESOURCE_GROUP${NC}"
echo -e "  Location: $AZURE_LOCATION\n"

# ============================================================================
# Step 3.5: List ALL resources for diagnostics
# ============================================================================
echo -e "${YELLOW}Step 3.5: Listing all resources in resource group...${NC}"

ALL_RESOURCES=$(az resource list --resource-group "$AZURE_RESOURCE_GROUP" --query "[].{name:name, type:type}" -o json)
RESOURCE_COUNT=$(echo "$ALL_RESOURCES" | jq length)

echo -e "${GREEN}✓ Found $RESOURCE_COUNT total resources${NC}"
echo "$ALL_RESOURCES" | jq -r '.[] | "  • \(.type): \(.name)"'
echo ""

# ============================================================================
# Step 4: Discover Azure OpenAI resources (FIXED for Cognitive Services)
# ============================================================================
echo -e "${YELLOW}Step 4: Discovering Azure OpenAI resources...${NC}"

# Look for Cognitive Services accounts with kind='OpenAI' OR kind='AIServices'
AOAI_RESOURCES=$(az resource list \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --resource-type "Microsoft.CognitiveServices/accounts" \
    --query "[?kind=='OpenAI' || kind=='AIServices'].{name:name, id:id, kind:kind}" \
    -o json 2>/dev/null || echo "[]")

AOAI_COUNT=$(echo "$AOAI_RESOURCES" | jq length 2>/dev/null || echo "0")

# If found, get full details including endpoint
if [ "$AOAI_COUNT" -gt 0 ]; then
    AOAI_NAME=$(echo "$AOAI_RESOURCES" | jq -r '.[0].name')
    AOAI_KIND=$(echo "$AOAI_RESOURCES" | jq -r '.[0].kind')
    
    # Get endpoint using cognitiveservices command
    AOAI_DETAILS=$(az cognitiveservices account show \
        --name "$AOAI_NAME" \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --query "{endpoint:properties.endpoint, kind:kind}" \
        -o json 2>/dev/null || echo "{}")
    
    AZURE_OPENAI_ENDPOINT=$(echo "$AOAI_DETAILS" | jq -r '.endpoint // ""')

    echo -e "${GREEN}✓ Found Azure OpenAI (Cognitive Services): $AOAI_NAME${NC}"
    echo -e "  Kind: $AOAI_KIND"
    echo -e "  Endpoint: $AZURE_OPENAI_ENDPOINT"
    
    # Get deployments
    DEPLOYMENTS=$(az cognitiveservices account deployment list \
        --name "$AOAI_NAME" \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --query "[].{name:name, model:properties.model.name, version:properties.model.version, capacity:sku.capacity}" \
        -o json 2>/dev/null || echo "[]")
    
    echo -e "  Deployments found: $(echo "$DEPLOYMENTS" | jq length)"
    echo "$DEPLOYMENTS" | jq -r '.[] | "    - \(.name) (\(.model))"'
    
    # Try to identify agent and embedding deployments
    AZURE_AI_AGENT_DEPLOYMENT_NAME=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("gpt-4"; "i"))] | .[0].name // ""')
    AZURE_AI_AGENT_MODEL_NAME=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("gpt-4"; "i"))] | .[0].model // "gpt-4"')
    AZURE_AI_AGENT_MODEL_VERSION=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("gpt-4"; "i"))] | .[0].version // "2024-05-13"')
    AZURE_AI_AGENT_DEPLOYMENT_CAPACITY=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("gpt-4"; "i"))] | .[0].capacity // "10"')
    
    AZURE_AI_EMBED_DEPLOYMENT_NAME=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("embedding|embed"; "i"))] | .[0].name // ""')
    AZURE_AI_EMBED_MODEL_NAME=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("embedding|embed"; "i"))] | .[0].model // "text-embedding-ada-002"')
    AZURE_AI_EMBED_MODEL_VERSION=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("embedding|embed"; "i"))] | .[0].version // "2"')
    AZURE_AI_EMBED_DEPLOYMENT_CAPACITY=$(echo "$DEPLOYMENTS" | jq -r '[.[] | select(.model | test("embedding|embed"; "i"))] | .[0].capacity // "10"')
else
    echo -e "${YELLOW}⚠ No Azure OpenAI resources found${NC}"
    echo -e "${YELLOW}Looking for these resource types:${NC}"
    echo "$ALL_RESOURCES" | jq -r '.[] | select(.type | test("CognitiveServices"; "i")) | "  • \(.type): \(.name)"'
    
    AOAI_NAME=""
    AZURE_OPENAI_ENDPOINT=""
    AZURE_AI_AGENT_DEPLOYMENT_NAME="gpt-4"
    AZURE_AI_AGENT_MODEL_NAME="gpt-4"
    AZURE_AI_AGENT_MODEL_VERSION="2024-05-13"
    AZURE_AI_AGENT_DEPLOYMENT_CAPACITY="10"
    AZURE_AI_EMBED_DEPLOYMENT_NAME="text-embedding-ada-002"
    AZURE_AI_EMBED_MODEL_NAME="text-embedding-ada-002"
    AZURE_AI_EMBED_MODEL_VERSION="2"
    AZURE_AI_EMBED_DEPLOYMENT_CAPACITY="10"
fi
echo ""

# ============================================================================
# Step 5: Discover Azure AI Search resources
# ============================================================================
echo -e "${YELLOW}Step 5: Discovering Azure AI Search resources...${NC}"

SEARCH_SERVICES=$(az search service list \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --query "[].{name:name}" \
    -o json 2>/dev/null || echo "[]")

SEARCH_COUNT=$(echo "$SEARCH_SERVICES" | jq length)

if [ "$SEARCH_COUNT" -gt 0 ]; then
    SEARCH_NAME=$(echo "$SEARCH_SERVICES" | jq -r '.[0].name')
    AZURE_AI_SEARCH_ENDPOINT="https://${SEARCH_NAME}.search.windows.net"
    
    echo -e "${GREEN}✓ Found Azure AI Search: $SEARCH_NAME${NC}"
    echo -e "  Endpoint: $AZURE_AI_SEARCH_ENDPOINT"
    
    # Try to get indexes
    INDEXES=$(az search index list \
        --service-name "$SEARCH_NAME" \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --query "[].name" \
        -o tsv 2>/dev/null || echo "")
    
    if [ -n "$INDEXES" ]; then
        AZURE_AI_SEARCH_INDEX_NAME=$(echo "$INDEXES" | head -n 1)
        echo -e "  Index: $AZURE_AI_SEARCH_INDEX_NAME"
    else
        AZURE_AI_SEARCH_INDEX_NAME="zava-products"
        echo -e "  ${YELLOW}No indexes found, using default: $AZURE_AI_SEARCH_INDEX_NAME${NC}"
    fi
else
    echo -e "${YELLOW}⚠ No Azure AI Search resources found${NC}"
    SEARCH_NAME=""
    AZURE_AI_SEARCH_ENDPOINT=""
    AZURE_AI_SEARCH_INDEX_NAME="zava-products"
fi
echo ""

# ============================================================================
# Step 6: Discover AI Foundry Project (FIXED for AI Services)
# ============================================================================
echo -e "${YELLOW}Step 6: Discovering AI Foundry Project...${NC}"

# First try: Look for AI Projects as sub-resources under Cognitive Services
AI_PROJECT_RESOURCES=$(az resource list \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --resource-type "Microsoft.CognitiveServices/accounts/projects" \
    --query "[].{name:name, id:id, parentName:name}" \
    -o json 2>/dev/null || echo "[]")

AI_PROJECT_COUNT=$(echo "$AI_PROJECT_RESOURCES" | jq length)

# Second try: Look for ML workspaces if no project sub-resources found
if [ "$AI_PROJECT_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}No project sub-resources found, checking ML workspaces...${NC}"
    AI_PROJECT_RESOURCES=$(az resource list \
        --resource-group "$AZURE_RESOURCE_GROUP" \
        --resource-type "Microsoft.MachineLearningServices/workspaces" \
        --query "[].{name:name, id:id, kind:kind}" \
        -o json 2>/dev/null || echo "[]")
    AI_PROJECT_COUNT=$(echo "$AI_PROJECT_RESOURCES" | jq length)
fi

if [ "$AI_PROJECT_COUNT" -gt 0 ]; then
    # Extract the project name (it might be in format "parent/project")
    FULL_PROJECT_NAME=$(echo "$AI_PROJECT_RESOURCES" | jq -r '.[0].name')
    
    # If it's a sub-resource (contains /), extract just the project name
    if [[ "$FULL_PROJECT_NAME" == *"/"* ]]; then
        AZURE_AI_PROJECT_NAME=$(echo "$FULL_PROJECT_NAME" | cut -d'/' -f2)
        PARENT_ACCOUNT=$(echo "$FULL_PROJECT_NAME" | cut -d'/' -f1)
        echo -e "${GREEN}✓ Found AI Foundry Project: $AZURE_AI_PROJECT_NAME${NC}"
        echo -e "  Parent Account: $PARENT_ACCOUNT"
    else
        AZURE_AI_PROJECT_NAME="$FULL_PROJECT_NAME"
        echo -e "${GREEN}✓ Found AI Project (ML Workspace): $AZURE_AI_PROJECT_NAME${NC}"
    fi
    
    AZURE_EXISTING_AIPROJECT_RESOURCE_ID=$(echo "$AI_PROJECT_RESOURCES" | jq -r '.[0].id')
    echo -e "  Resource ID: $AZURE_EXISTING_AIPROJECT_RESOURCE_ID"
    
    # Try to construct endpoint from resource ID
    if [[ "$AZURE_EXISTING_AIPROJECT_RESOURCE_ID" == *"/projects/"* ]]; then
        # It's a project sub-resource, construct AI Services project endpoint
        AZURE_EXISTING_AIPROJECT_ENDPOINT="${AZURE_OPENAI_ENDPOINT}"
    else
        # Try to get ML workspace endpoint
        PROJECT_DETAILS=$(az ml workspace show \
            --name "$AZURE_AI_PROJECT_NAME" \
            --resource-group "$AZURE_RESOURCE_GROUP" \
            --query "{discoveryUrl: discovery_url, mlFlowTrackingUri: mlflow_tracking_uri}" \
            -o json 2>/dev/null || echo "{}")
        
        AZURE_EXISTING_AIPROJECT_ENDPOINT=$(echo "$PROJECT_DETAILS" | jq -r '.discoveryUrl // ""')
    fi
    
    if [ -n "$AZURE_EXISTING_AIPROJECT_ENDPOINT" ] && [ "$AZURE_EXISTING_AIPROJECT_ENDPOINT" != "null" ]; then
        echo -e "  Endpoint: $AZURE_EXISTING_AIPROJECT_ENDPOINT"
    fi
else
    echo -e "${YELLOW}⚠ No AI Foundry Project found${NC}"
    echo -e "${YELLOW}Looking for these resource types:${NC}"
    echo "$ALL_RESOURCES" | jq -r '.[] | select(.type | test("MachineLearning|AIServices|projects"; "i")) | "  • \(.type): \(.name)"'
    
    AZURE_AI_PROJECT_NAME=""
    AZURE_EXISTING_AIPROJECT_ENDPOINT=""
    AZURE_EXISTING_AIPROJECT_RESOURCE_ID=""
fi
echo ""

# ============================================================================
# Step 7: Discover Application Insights
# ============================================================================
echo -e "${YELLOW}Step 7: Discovering Application Insights...${NC}"

APPINSIGHTS_RESOURCES=$(az resource list \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --resource-type "Microsoft.Insights/components" \
    --query "[].name" \
    -o tsv 2>/dev/null || echo "")

if [ -n "$APPINSIGHTS_RESOURCES" ]; then
    APPINSIGHTS_NAME=$(echo "$APPINSIGHTS_RESOURCES" | head -n 1)
    
    APPINSIGHTS_DATA=$(az resource show \
        --ids "/subscriptions/$AZURE_SUBSCRIPTION_ID/resourceGroups/$AZURE_RESOURCE_GROUP/providers/Microsoft.Insights/components/$APPINSIGHTS_NAME" \
        --query "{connectionString: properties.ConnectionString, instrumentationKey: properties.InstrumentationKey}" \
        -o json 2>/dev/null || echo "{}")
    
    APPLICATIONINSIGHTS_CONNECTION_STRING=$(echo "$APPINSIGHTS_DATA" | jq -r '.connectionString // ""')
    APPLICATIONINSIGHTS_INSTRUMENTATION_KEY=$(echo "$APPINSIGHTS_DATA" | jq -r '.instrumentationKey // ""')
    
    echo -e "${GREEN}✓ Found Application Insights: $APPINSIGHTS_NAME${NC}"
else
    echo -e "${YELLOW}⚠ No Application Insights found${NC}"
    APPLICATIONINSIGHTS_CONNECTION_STRING=""
    APPLICATIONINSIGHTS_INSTRUMENTATION_KEY=""
fi
echo ""

# ============================================================================
# Step 8: Discover Container Apps and Registry
# ============================================================================
echo -e "${YELLOW}Step 8: Discovering Container Apps resources...${NC}"

# Container Registry
ACR_RESOURCES=$(az acr list \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --query "[].{name:name, loginServer:loginServer}" \
    -o json 2>/dev/null || echo "[]")

ACR_COUNT=$(echo "$ACR_RESOURCES" | jq length)

if [ "$ACR_COUNT" -gt 0 ]; then
    ACR_NAME=$(echo "$ACR_RESOURCES" | jq -r '.[0].name')
    AZURE_CONTAINER_REGISTRY_ENDPOINT=$(echo "$ACR_RESOURCES" | jq -r '.[0].loginServer')
    echo -e "${GREEN}✓ Found Container Registry: $ACR_NAME${NC}"
else
    echo -e "${YELLOW}⚠ No Container Registry found${NC}"
    AZURE_CONTAINER_REGISTRY_ENDPOINT=""
fi

# Container Apps Environment
CA_ENV=$(az containerapp env list \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --query "[].name" \
    -o tsv 2>/dev/null | head -n 1 || echo "")

if [ -n "$CA_ENV" ]; then
    AZURE_CONTAINER_ENVIRONMENT_NAME="$CA_ENV"
    echo -e "${GREEN}✓ Found Container Apps Environment: $CA_ENV${NC}"
else
    AZURE_CONTAINER_ENVIRONMENT_NAME=""
fi

# Container Apps
CA_APPS=$(az containerapp list \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --query "[].{name:name, fqdn:properties.configuration.ingress.fqdn}" \
    -o json 2>/dev/null || echo "[]")

CA_APP_COUNT=$(echo "$CA_APPS" | jq length)

if [ "$CA_APP_COUNT" -gt 0 ]; then
    SERVICE_API_NAME=$(echo "$CA_APPS" | jq -r '.[0].name')
    SERVICE_FQDN=$(echo "$CA_APPS" | jq -r '.[0].fqdn // ""')
    
    if [ -n "$SERVICE_FQDN" ]; then
        SERVICE_API_URI="https://${SERVICE_FQDN}"
        echo -e "${GREEN}✓ Found Container App: $SERVICE_API_NAME${NC}"
        echo -e "  URI: $SERVICE_API_URI"
    else
        SERVICE_API_URI=""
    fi
else
    SERVICE_API_NAME=""
    SERVICE_API_URI=""
fi
echo ""

# ============================================================================
# Step 9: Generate the new .env file
# ============================================================================
echo -e "${YELLOW}Step 9: Generating .env file...${NC}"

# Set defaults
AZURE_ENV_NAME="${AZURE_ENV_NAME:-${AZURE_RESOURCE_GROUP}}"
AZURE_AI_AGENT_NAME="${AZURE_AI_AGENT_NAME:-contoso-support-agent}"
SERVICE_API_AND_FRONTEND_IMAGE_NAME="${SERVICE_API_AND_FRONTEND_IMAGE_NAME:-contoso-app}"
USE_APPLICATION_INSIGHTS="${USE_APPLICATION_INSIGHTS:-true}"
ENABLE_AZURE_MONITOR_TRACING="${ENABLE_AZURE_MONITOR_TRACING:-true}"
AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED="${AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED:-true}"

# Generate new .env
cat > "$ENV_FILE" << EOF
# ============================================================================
# Azure Environment Variables
# Auto-generated by 00-get-env-skillable-fixed.sh on $(date)
# Resource Group: $AZURE_RESOURCE_GROUP
# ============================================================================

# .... Azure Environment Variables
AZURE_ENV_NAME="$AZURE_ENV_NAME"
AZURE_LOCATION="$AZURE_LOCATION"
AZURE_RESOURCE_GROUP="$AZURE_RESOURCE_GROUP"
AZURE_SUBSCRIPTION_ID="$AZURE_SUBSCRIPTION_ID"
AZURE_TENANT_ID="$AZURE_TENANT_ID"

# .... Azure AI Foundry
AZURE_OPENAI_API_KEY=
AZURE_OPENAI_ENDPOINT="$AZURE_OPENAI_ENDPOINT"
AZURE_OPENAI_API_VERSION="2025-02-01-preview"
AZURE_OPENAI_DEPLOYMENT="$AZURE_AI_AGENT_DEPLOYMENT_NAME"

# .... Azure AI Foundry Resources
AZURE_AI_FOUNDRY_NAME="$AOAI_NAME"
AZURE_AI_PROJECT_NAME="$AZURE_AI_PROJECT_NAME"
AZURE_EXISTING_AIPROJECT_ENDPOINT="$AZURE_EXISTING_AIPROJECT_ENDPOINT"
AZURE_EXISTING_AIPROJECT_RESOURCE_ID="$AZURE_EXISTING_AIPROJECT_RESOURCE_ID"

# .... Azure AI Search
AZURE_SEARCH_ENDPOINT="$AZURE_AI_SEARCH_ENDPOINT"
AZURE_AISEARCH_ENDPOINT="$AZURE_AI_SEARCH_ENDPOINT"
AZURE_AI_SEARCH_ENDPOINT="$AZURE_AI_SEARCH_ENDPOINT"
AZURE_SEARCH_API_KEY=
AZURE_SEARCH_INDEX_NAME="$AZURE_AI_SEARCH_INDEX_NAME"
AZURE_AISEARCH_INDEX="$AZURE_AI_SEARCH_INDEX_NAME"
AZURE_AI_SEARCH_INDEX_NAME="$AZURE_AI_SEARCH_INDEX_NAME"

# .... Agent Configuration
AZURE_AI_AGENT_DEPLOYMENT_NAME="$AZURE_AI_AGENT_DEPLOYMENT_NAME"
AZURE_AI_AGENT_MODEL_NAME="$AZURE_AI_AGENT_MODEL_NAME"
AZURE_AI_AGENT_MODEL_VERSION="$AZURE_AI_AGENT_MODEL_VERSION"
AZURE_AI_AGENT_DEPLOYMENT_CAPACITY=$AZURE_AI_AGENT_DEPLOYMENT_CAPACITY
AZURE_AI_AGENT_NAME="$AZURE_AI_AGENT_NAME"

# .... Embedding Model Configuration
AZURE_AI_EMBED_DEPLOYMENT_NAME="$AZURE_AI_EMBED_DEPLOYMENT_NAME"
AZURE_AI_EMBED_MODEL_NAME="$AZURE_AI_EMBED_MODEL_NAME"
AZURE_AI_EMBED_MODEL_VERSION=$AZURE_AI_EMBED_MODEL_VERSION
AZURE_AI_EMBED_DEPLOYMENT_CAPACITY=$AZURE_AI_EMBED_DEPLOYMENT_CAPACITY
AZURE_AI_EMBED_DEPLOYMENT_SKU="Standard"
AZURE_AI_EMBED_DIMENSIONS=1536
AZURE_AI_EMBED_MODEL_FORMAT="OpenAI"

# .... Container Apps & Registry
AZURE_CONTAINER_ENVIRONMENT_NAME="$AZURE_CONTAINER_ENVIRONMENT_NAME"
AZURE_CONTAINER_REGISTRY_ENDPOINT="$AZURE_CONTAINER_REGISTRY_ENDPOINT"
SERVICE_API_NAME="$SERVICE_API_NAME"
SERVICE_API_URI="$SERVICE_API_URI"
SERVICE_API_ENDPOINTS='{"api": "$SERVICE_API_URI"}'
SERVICE_API_IDENTITY_PRINCIPAL_ID=""
SERVICE_API_AND_FRONTEND_IMAGE_NAME="$SERVICE_API_AND_FRONTEND_IMAGE_NAME"

# .... Monitoring & Tracing
USE_APPLICATION_INSIGHTS="$USE_APPLICATION_INSIGHTS"
ENABLE_AZURE_MONITOR_TRACING="$ENABLE_AZURE_MONITOR_TRACING"
AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED="$AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED"
APPLICATIONINSIGHTS_CONNECTION_STRING="$APPLICATIONINSIGHTS_CONNECTION_STRING"
APPLICATIONINSIGHTS_INSTRUMENTATION_KEY="$APPLICATIONINSIGHTS_INSTRUMENTATION_KEY"
EOF

echo -e "${GREEN}✓ Generated new .env file${NC}\n"

# ============================================================================
# Summary
# ============================================================================
echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}Summary${NC}"
echo -e "${BLUE}======================================${NC}\n"

echo -e "${GREEN}✅ Successfully created .env file!${NC}\n"

echo -e "${YELLOW}📋 Discovered Resources:${NC}"
echo -e "  • Resource Group: $AZURE_RESOURCE_GROUP"
echo -e "  • Location: $AZURE_LOCATION"
[ -n "$AZURE_OPENAI_ENDPOINT" ] && echo -e "  • OpenAI: ${GREEN}✓${NC} $AOAI_NAME" || echo -e "  • OpenAI: ${YELLOW}✗${NC}"
[ -n "$AZURE_AI_SEARCH_ENDPOINT" ] && echo -e "  • AI Search: ${GREEN}✓${NC} $SEARCH_NAME" || echo -e "  • AI Search: ${YELLOW}✗${NC}"
[ -n "$AZURE_AI_PROJECT_NAME" ] && echo -e "  • AI Project: ${GREEN}✓${NC} $AZURE_AI_PROJECT_NAME" || echo -e "  • AI Project: ${YELLOW}✗${NC}"
[ -n "$AZURE_CONTAINER_REGISTRY_ENDPOINT" ] && echo -e "  • Container Registry: ${GREEN}✓${NC} $ACR_NAME" || echo -e "  • Container Registry: ${YELLOW}✗${NC}"
[ -n "$SERVICE_API_URI" ] && echo -e "  • Container App: ${GREEN}✓${NC} $SERVICE_API_NAME" || echo -e "  • Container App: ${YELLOW}✗${NC}"
[ -n "$APPLICATIONINSIGHTS_CONNECTION_STRING" ] && echo -e "  • Application Insights: ${GREEN}✓${NC} $APPINSIGHTS_NAME" || echo -e "  • Application Insights: ${YELLOW}✗${NC}"

echo -e "\n${BLUE}======================================${NC}"
echo -e "${GREEN}✓ Done!${NC}"
echo -e "${BLUE}======================================${NC}\n"