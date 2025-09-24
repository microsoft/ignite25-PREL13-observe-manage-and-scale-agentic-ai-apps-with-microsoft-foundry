#!/bin/bash
echo "--- ZAVA INDEX CREATION: Update RBAC permissions---"

# Exit shell immediately if command exits with non-zero status
set -e

# Check if user is logged into Azure
echo "Checking Azure login status..."
if ! az account show &> /dev/null; then
    echo "Error: You are not logged into Azure. Please run 'az login' first."
    exit 1
fi
echo "Azure login confirmed."

# Load variables from .env file into your shell
if [ -f .env ]; then
    source .env
else
    echo ".env file not found!"
    exit 1
fi

# -------------- Get core environment variables -------------------------
# Get subscription ID from current Azure login
AZURE_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
if [ -z "$AZURE_SUBSCRIPTION_ID" ]; then
    echo "Error: Could not retrieve subscription ID from Azure login."
    exit 1
fi
echo "Using subscription: $AZURE_SUBSCRIPTION_ID"

# Check if resource group is provided in .env, otherwise prompt for it
if [ -z "$AZURE_AISEARCH_RESOURCE_GROUP" ]; then
    echo "Error: AZURE_AISEARCH_RESOURCE_GROUP is not set in .env file."
    exit 1
fi

echo "Using resource group: $AZURE_AISEARCH_RESOURCE_GROUP"

# Get principal id from authenticated account
PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)
if [ -z "$PRINCIPAL_ID" ]; then
    echo "Error: Could not retrieve principal ID from Azure login."
    exit 1
fi
echo "Using principal ID: $PRINCIPAL_ID"


echo "All required environment variables are set. Proceeding..."

# -------------- Create any additional RBAC roles required -------------------------

# Search Index Data Contributor
# Grants full access to Azure Cognitive Search index data.
az role assignment create \
        --role "8ebe5a00-799e-43f5-93ac-243d3dce84a7" \
        --assignee-object-id "${PRINCIPAL_ID}" \
        --scope /subscriptions/"${AZURE_SUBSCRIPTION_ID}"/resourceGroups/"${AZURE_AISEARCH_RESOURCE_GROUP}" \
        --assignee-principal-type 'User'

# Search Index Data Reader
# Grants read access to Azure Cognitive Search index data.
az role assignment create \
        --role "1407120a-92aa-4202-b7e9-c0e197c71c8f" \
        --assignee-object-id "${PRINCIPAL_ID}" \
        --scope /subscriptions/"${AZURE_SUBSCRIPTION_ID}"/resourceGroups/"${AZURE_AISEARCH_RESOURCE_GROUP}" \
        --assignee-principal-type 'User'

# Cognitive Services OpenAI User
# Read access to view files, models, deployments. The ability to create completion and embedding calls.
az role assignment create \
        --role "5e0bd9bd-7b93-4f28-af87-19fc36ad61bd" \
        --assignee-object-id "${PRINCIPAL_ID}" \
        --scope /subscriptions/"${AZURE_SUBSCRIPTION_ID}"/resourceGroups/"${AZURE_AISEARCH_RESOURCE_GROUP}" \
        --assignee-principal-type 'User'


echo "--- ZAVA INDEX CREATION: Permissions---"