# Multi-Agent Orchestration

!!! info "Objective"

    Build specialized agents that work together using Microsoft Agent Framework orchestration patterns.

## 1. Description

Learn how to create multi-agent systems where specialized agents collaborate on complex tasks. This lab demonstrates building separate inventory and customer service agents for Zava, connecting them to Azure AI Search, and orchestrating their interactions to provide comprehensive customer assistance.

## 2. Scenario

As Zava Hardware Store grows, Cora needs help from specialized teammates. This lab evolves the single-agent approach into a multi-agent system where one agent focuses on technical product specifications and inventory management while another handles customer-friendly recommendations. This division of labor mirrors real retail operations where technical experts and customer service representatives work together to serve customers effectively.

## 3. Instructions

!!! lab "NOTEBOOK: Multi-Agent Orchestration"

    **📓 Open:** [`labs/1-agents/12-agent-framework-orchestration.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/1-agents/12-agent-framework-orchestration.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Configure Azure AI Search connection for product database access
2. Create Product Inventory Agent with technical expertise personality
3. Create Customer Service Agent with helpful, friendly personality
4. Set up agent routing to direct queries to the appropriate specialist
5. Test multi-agent coordination with complex customer scenarios

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to create specialized agents with different roles and personalities using Agent Framework
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain the benefits of multi-agent systems versus single-agent architectures
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Help me understand agent orchestration patterns like sequential, parallel, and handoff
    ```

## 5. Related Resources

- 📘 [Microsoft Agent Framework Orchestration Patterns](https://learn.microsoft.com/agent-framework/user-guide/workflows/orchestrations/overview)
- 📘 [Deterministic Multi-Agent Orchestrations with Durable Agents](https://learn.microsoft.com/agent-framework/user-guide/agents/agent-types/durable-agent/features)
- 📘 [Group Chat and Handoff Orchestration Patterns](https://learn.microsoft.com/agent-framework/user-guide/workflows/orchestrations/group-chat)

## 6. Key Takeaways

- Multi-agent systems enable specialization where each agent focuses on specific expertise domains, improving response quality
- Agent orchestration patterns (sequential, concurrent, handoff) provide flexible ways to coordinate multiple agents for complex workflows
- Microsoft Agent Framework abstracts orchestration complexity, allowing developers to focus on agent roles rather than coordination logic
