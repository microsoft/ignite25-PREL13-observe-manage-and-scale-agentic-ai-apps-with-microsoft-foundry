# Lab 0: Setup & Validation

Welcome to the workshop! This lab ensures your Azure environment is properly configured and introduces you to the Zava customer service chatbot scenario.

## Description

In this lab, you'll validate that your Azure AI Foundry infrastructure is correctly provisioned and accessible. You'll also learn about the Zava Enterprise Retailer application scenario that serves as the foundation for all subsequent labs.

## Learning Objectives

By the end of this lab, you will be able to:

- ✅ Validate Azure AI Foundry project configuration
- ✅ Verify deployed model endpoints and connections
- ✅ Understand the Zava multi-agent customer service scenario
- ✅ Access and run Jupyter notebooks in your development environment
- ✅ Confirm Azure SDK and dependency installations

## Prerequisites

### For In-Venue (Skillable) Participants:
- Pre-provisioned Azure subscription (provided by instructor)
- Lab environment credentials
- Web browser access

### For Self-Guided Participants:
- Valid Azure subscription with sufficient credits
- Owner or Contributor permissions on the subscription
- Ability to create Azure AI Foundry resources

## Instructions

### Step 1: Access the Validation Notebook

Navigate to the setup lab folder:

```bash
cd labs/0-setup
```

Open the validation notebook:
- **File:** `00-validate-setup.ipynb`

### Step 2: Run Validation Checks

The notebook will verify:

1. **Azure Authentication:** Confirms you can authenticate to Azure
2. **AI Foundry Project:** Checks project exists and is accessible
3. **Model Deployments:** Verifies required models are deployed
4. **Connections:** Tests AI Search and other service connections
5. **SDK Installation:** Confirms required Python packages

Follow the notebook cells sequentially and ensure all checks pass with ✅.

### Step 3: Environment Setup (Self-Guided Only)

If you're running self-guided, you may need to run setup scripts:

```bash
cd /workspaces/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/scripts
./1-setup.sh
```

This script provisions:
- Azure AI Foundry hub and project
- Required model deployments
- AI Search service with product index
- Role assignments and permissions

## Copilot Prompts

Use these prompts with GitHub Copilot to assist with the lab:

```
Explain the Azure AI Foundry project structure and how it relates to hubs and workspaces
```

```
Show me how to authenticate to Azure using DefaultAzureCredential in Python
```

```
What are the key components I need to validate before building an agentic AI application on Azure?
```

```
Help me troubleshoot authentication errors when connecting to Azure AI Foundry
```

## Expected Outcomes

After completing this lab, you should see:

- ✅ All validation checks passing in the notebook
- ✅ Understanding of the Zava scenario and requirements
- ✅ Familiarity with the lab structure and navigation

## Troubleshooting

### Common Issues:

**Authentication Failures:**
- Ensure you're logged in to Azure CLI: `az login`
- Check subscription access: `az account show`

**Missing Model Deployments:**
- Verify models in Azure AI Foundry portal
- Check deployment names match configuration

**Package Installation Errors:**
- Update pip: `pip install --upgrade pip`
- Install requirements: `pip install -r requirements.txt`

## Related Resources

- 📘 [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)
- 📘 [Quickstart: Get Started with Azure AI Foundry](https://learn.microsoft.com/azure/ai-studio/quickstart)
- 📘 [Azure AI SDK for Python](https://learn.microsoft.com/python/api/overview/azure/ai)
- 📄 [Workshop Outline](../outline.md)

## Next Steps

Once you've successfully validated your environment, proceed to:

After completing this lab:

**[Lab 1: Agent Architecture →](../1-agents/11-agent-service.md)**

Build your first agents using Azure AI Agent Service and Microsoft Agent Framework!

---

**Lab Files:**
- 📓 [00-validate-setup.ipynb](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/0-setup/00-validate-setup.ipynb)
- 📖 [README (Skillable)](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/0-setup/README.skillable.md)
- 📖 [README (Self-Guided)](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/0-setup/README.self-guided.md)
