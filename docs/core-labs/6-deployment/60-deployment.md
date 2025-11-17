# Deploying to Azure

!!! info "Objective"

    Deploy your AI agent to Azure for production use with monitoring and scalability.

## 1. Description

This lab guides you through deploying the Cora retail agent to Azure. You'll learn about deployment options, scaling considerations, and production monitoring.

## 2. Scenario

After development and testing, Zava is ready to deploy Cora to production. This lab covers the deployment process, including infrastructure setup, configuration management, and post-deployment verification.

## 3. Instructions

!!! lab "NOTEBOOK: Deploying to Azure"

    **📓 Open:** [`labs/6-deployment/60-deployment.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/6-deployment/60-deployment.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Deploy agents using Azure AI Foundry developer tier
2. Configure production endpoints and authentication
3. Set up monitoring and alerting
4. Test deployed agent functionality
5. Understand scaling and performance considerations
6. Review deployment best practices

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts.

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain the difference between developer tier and enterprise deployment options
    ```

## 5. Related Resources

- 📘 [Deploy AI Agents to Azure](https://learn.microsoft.com/azure/ai-foundry/agents/deploy)
- 📘 [Azure AI Foundry Deployment Options](https://learn.microsoft.com/azure/ai-foundry/concepts/deployments-overview)
- 📘 [Monitoring AI Applications](https://learn.microsoft.com/azure/ai-foundry/how-to/monitor-overview)
- 📘 [Production Best Practices](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/production-best-practices)

## 6. Key Takeaways

- Azure AI Foundry provides multiple deployment tiers to match your production requirements
- Proper monitoring and observability are essential for production agent reliability
- Authentication, rate limiting, and content safety should be configured before production launch
- The developer tier enables rapid iteration while enterprise deployment provides full production capabilities

---

!!! note "Next Step"
    Deployment steps complete? Close the notebook and proceed to teardown or further optimization labs.

