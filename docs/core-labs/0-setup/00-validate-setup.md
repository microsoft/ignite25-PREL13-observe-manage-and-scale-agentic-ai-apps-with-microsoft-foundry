# Validate Setup

## 1. Objective

Ensure your Azure AI Foundry environment is properly configured and all required resources are accessible before proceeding with the workshop labs.

## 2. Scenario

Before building Cora, Zava's AI customer service assistant, you need to verify that all Azure resources are provisioned correctly. This includes confirming that your Azure AI Foundry project exists, model deployments are accessible, and service connections (like Azure AI Search) are functioning. Think of this as a pre-flight check—validating infrastructure before development begins ensures a smooth workshop experience.

## 3. Instructions

!!! lab "NOTEBOOK: Validate Setup"

    **📓 Open:** [`labs/0-setup/00-validate-setup.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/0-setup/00-validate-setup.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially
    4. Verify all checks pass with ✅

**What you'll learn in this lab:**

1. Authenticate to Azure using DefaultAzureCredential
2. Verify Azure AI Foundry project configuration and accessibility
3. Confirm required model deployments are available
4. Test connections to Azure AI Search and other dependent services
5. Validate Python SDK installations and environment configuration

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to authenticate to Azure using DefaultAzureCredential and verify my Azure AI Foundry project connection
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain the Azure AI Foundry project structure and how it relates to hubs, workspaces, and deployments
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Help me troubleshoot authentication errors when connecting to Azure AI Foundry from Python
    ```

## 5. Related Resources

- 📘 [Azure AI Foundry SDK Documentation](https://learn.microsoft.com/python/api/overview/azure/ai)
- 📘 [Authentication with Azure Identity](https://learn.microsoft.com/python/api/overview/azure/identity-readme)
- 📘 [Azure AI Foundry Project Setup](https://learn.microsoft.com/azure/ai-foundry/how-to/create-projects)

## 6. Key Takeaways

- DefaultAzureCredential provides flexible authentication across local development and Azure environments
- Azure AI Foundry projects organize resources including models, connections, and deployments in a unified workspace
- Pre-deployment validation prevents runtime errors and ensures smooth development workflows
