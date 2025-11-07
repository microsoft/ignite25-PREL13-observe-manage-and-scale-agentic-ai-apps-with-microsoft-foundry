# Infrastructure Setup Scripts

This README documents the infrastructure setup & configuration scripts in this folder. 

**For Workshop Participants:**

Usage of the scripts is documented in the workshop guide. To launch the guide, open a VS Code terminal at the root of this repository and run this command. You will see a pop-up dialog - confirm to open the guide in the browser. Then follow Getting Started instructions there.

```bash 
mkdocs serve
```

**For Workshop Maintainers & Instructors:**

The rest of this README.md is for you. It gives you a sense of what the scripts do and how to troubleshoot issues if needed. The scripts were generated with GitHub Copilot (GHCP) Agent mode assistance to ensure consistent usage and documentation. We recommend using GHCP to ask questions or explore modifications on your own.

<br/>

## 📁 1. Directory Structure

The figure shows the folder hierarchy in this directory. It contains scripts for two different audiences:

1. At-Home Learners: use scripts 1-6 for provisioning infrastructure yourself
1. In-Venue Learners: use script 7 to configure local env for pre-provsioned infra

Take a quick look at the file names and functionality identified here.

```
scripts/
├── .env.sample                        # Template for environment variables
├── README.md                          # This file
├── 1-get-env.sh                       # Update .env from deployment
├── 1-setup.sh                         # Set up Azure infrastructure
├── 2-add-models.sh                    # Add more AI models
├── 2-add-product-index.py             # Load products into search index
├── 2-add-products-rbac.sh             # Grant search access permissions
├── 3-teardown.sh                      # Delete all resources
├── 7-get-env-skillable.sh             # Setup for Skillable labs
└── customization/                     # Configuration files
    ├── add-models.bicep               # Template for adding models
    ├── add-models.json                # Available AI models list
    ├── add-models-high-capacity.json  # High-capacity model config
    ├── add-products.csv               # Full product catalog
    ├── add-products-50.csv            # Sample: 50 products
    └── add-products-423.csv           # Sample: 423 products
```

<br/>

## 🚀 2. Self-Guided Setup

### 2.1 Prerequisites

- Azure subscription
- Azure CLI (`az`) installed
- Azure Developer CLI (`azd`) installed
- `jq` installed
- Bash shell

### 2.2 Login to Azure

Authenticate with your Azure account:

```bash
az login
```

### 2.3 Run Setup

Create and deploy your Azure infrastructure:

```bash
cd scripts/
./1-setup.sh
```

### 2.4 Update Environment File

Pull the connection details into your `.env` file:

```bash
./1-get-env.sh
```

### 2.5 Optional: Add More Models

Deploy additional AI models beyond the defaults:

```bash
./2-add-models.sh
```

### 2.6 Optional: Add Product Search

Set up product catalog search for your AI agent:

```bash
# Grant yourself search permissions
./2-add-products-rbac.sh

# Load product data
python 2-add-product-index.py
```

### 2.7 Clean Up When Done

Remove all Azure resources when you're finished:

```bash
./3-teardown.sh
```

<br/>

## 💻 3. Skillable Setup

Using pre-deployed resources in a Skillable lab? Follow these steps to configure your environment:

```bash
# Log in with Skillable credentials
az login

# Auto-configure environment
cd scripts/
./7-get-env-skillable.sh
```

This script will:
- Find your resource group automatically
- Discover all deployed resources
- Create a `.env` file with connection details

<br/>

## 📖 Detailed Script Guide

#### 1️⃣ **Initial Setup** - `1-setup.sh`

Sets up your Azure infrastructure from scratch.

**What it does:**
- Downloads the ForBeginners repository
- Creates an Azure environment
- Deploys Azure AI resources to your subscription

**Usage:**
```bash
cd scripts/
./1-setup.sh
```

**You'll be asked for:**
- Environment name (like "my-ai-lab")
- Azure region (like "eastus")
- Azure subscription to use

**Result:**
- Azure AI Foundry project created with default AI models

---

#### 2️⃣ **Add AI Models** - `2-add-models.sh`

Adds more AI models to your setup.

**Prerequisites:** Run `1-setup.sh` first

**What it does:**
- Shows which models are already deployed
- Shows which models you can add
- Deploys the models you select

**Usage:**
```bash
cd scripts/
./2-add-models.sh
```

**To select models:**
- Type numbers like `1 3 5` to deploy specific models
- Type `all` to deploy everything
- Type `cancel` to exit

**Result:**
- New AI models available in your project

---

#### 2️⃣ **Add Product Search Index** - `2-add-product-index.py`

Adds product data to Azure AI Search for the agent to use.

**Prerequisites:** Run `1-setup.sh` first (with Azure AI Search enabled)

**What it does:**
- Loads product data from a CSV file
- Creates embeddings for semantic search
- Uploads products to Azure AI Search index

**Usage:**
```bash
cd scripts/
python 2-add-product-index.py
```

**Options:**
- `--data-file`: Path to product CSV file (default: customization/add-products.csv)
- `--max-products`: Limit number of products to upload
- `--skip-rbac`: Skip role assignment setup

**Result:**
- Product catalog searchable by AI agents

---

#### 2️⃣ **Configure Search Access** - `2-add-products-rbac.sh`

Grants your account permission to access Azure AI Search.

**Prerequisites:** Run `1-setup.sh` first (with Azure AI Search enabled)

**What it does:**
- Assigns Search Index Data Contributor role
- Assigns Search Index Data Reader role
- Enables you to read/write search index data

**Usage:**
```bash
cd scripts/
./2-add-products-rbac.sh
```

**Result:**
- Your account can access and manage search index data

---

#### 3️⃣ **Teardown** - `3-teardown.sh`

Removes all Azure resources and cleans up files.

**Usage:**
```bash
cd scripts/
./3-teardown.sh
```

**What it does:**
- Deletes all Azure resources
- Removes the ForBeginners directory
- Frees up Azure quota

**⚠️ Warning:** This deletes everything and cannot be undone!

---

#### 1️⃣ **Update Environment** - `1-get-env.sh`

Updates your `.env` file with values from Azure deployment.

**Prerequisites:** Run `1-setup.sh` first

**What it does:**
- Finds your Azure deployment
- Retrieves endpoints and API keys
- Updates the `.env` file at the repository root

**Usage:**
```bash
cd scripts/
./1-get-env.sh
```

**Result:**
- `.env` file updated with Azure resource details

---

#### 7️⃣ **Skillable Setup** - `7-get-env-skillable.sh`

Configures environment for pre-deployed Skillable labs.

**Prerequisites:** Log in to Azure with Skillable credentials

**What it does:**
- Finds resource group with "rg-Ignite" prefix
- Discovers Azure OpenAI and AI Search resources
- Creates `.env` file with all needed values

**Usage:**
```bash
az login  # Use Skillable credentials
cd scripts/
./7-get-env-skillable.sh
```

**Result:**
- `.env` file ready for use with pre-deployed resources

**What happens:**
- Deletes all Azure resources
- Removes local ForBeginners directory
- Frees up Azure quota

<br/>

## 🔧 Configuration Files

### `customization/add-models.json`

Lists AI models that can be deployed. Each model has:
- Name and deployment settings
- Model format, name, and version
- Capacity (how much processing power)

Default capacity is 20 per model. For higher limits, use `add-models-high-capacity.json`.

### `customization/add-products.csv`

Product catalog data files:
- `add-products.csv` - Full catalog
- `add-products-50.csv` - 50 products (quick testing)
- `add-products-423.csv` - 423 products (medium set)

Used by `2-add-product-index.py` to populate the search index.

<br/>

## 📚 Learn More

- [Azure AI Foundry](https://learn.microsoft.com/azure/ai-studio/)
- [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/)
- [Azure OpenAI Models](https://learn.microsoft.com/azure/ai-services/openai/concepts/models)
- [ForBeginners Repository](https://github.com/microsoft/ForBeginners)
