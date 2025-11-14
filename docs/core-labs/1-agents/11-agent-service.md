# Build Cora Retail Agent

## 1. Objective

Learn how to build an intelligent customer service agent using Azure AI Agent Service's managed infrastructure. This lab covers agent creation, conversation management with threads, and integrating product search capabilities for Zava's hardware retail business.

## 2. Scenario

Cora is Zava's AI customer service representative who helps customers find the right hardware products, check inventory, and receive personalized assistance for home improvement projects. This lab establishes the foundation for Cora by creating the agent, configuring its personality, and setting up conversation threads to maintain customer interaction history across multiple turns.

## 3. Instructions

!!! lab "NOTEBOOK: Build Cora Retail Agent"

    **📓 Open:** [`labs/1-agents/11-build-cora-retail-agent.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/1-agents/11-build-cora-retail-agent.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially
    4. Read through explainers to understand outputs

**What you'll learn in this lab:**

1. Load environment variables and verify Azure AI Foundry project connection
2. Create Cora agent with instructions defining personality and role
3. Load Zava's product catalog for agent knowledge
4. Create conversation threads to manage customer interactions
5. Test Cora with sample customer queries about hardware products

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to create an agent with Azure AI Agent Service and configure its instructions and personality
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain how conversation threads work in Azure AI Agent Service and why they're important
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Help me understand the difference between agents, threads, messages, and runs in Azure AI Foundry
    ```

## 5. Related Resources

- 📘 [Threads, runs, and messages in Azure AI Foundry Agent Service](https://learn.microsoft.com/azure/ai-foundry/agents/concepts/threads-runs-messages)
- 📘 [Azure AI Foundry Agents - Multi-turn conversations](https://learn.microsoft.com/agent-framework/tutorials/agents/multi-turn-conversation)
- 📘 [Azure AI Foundry Agent Service Quickstart](https://learn.microsoft.com/azure/ai-foundry/agents/quickstart)

## 6. Key Takeaways

- Azure AI Agent Service provides managed infrastructure for building conversational AI agents with persistent conversation state
- Threads enable multi-turn conversations by maintaining message history automatically, allowing agents to reference previous interactions
- Agents are stateless orchestrators that combine instructions, tools, and model capabilities to respond intelligently to user queries
