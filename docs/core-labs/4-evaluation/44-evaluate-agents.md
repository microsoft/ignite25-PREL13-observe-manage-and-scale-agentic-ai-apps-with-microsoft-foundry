# Lab 4.4: Evaluate Agents

!!! info "Objective"
    Assess agent-specific performance metrics including intent resolution, tool usage, and task adherence.

## 1. Description

Evaluate agents on metrics specific to agentic AI systems, such as correct intent recognition, tool selection accuracy, and task completion fidelity. Azure AI Foundry provides specialized agent evaluators designed for multi-step agentic workflows that orchestrate tools and reasoning to accomplish user goals.

## 2. Scenario

**Cora is an agentic AI assistant** that orchestrates multiple steps—understanding customer intent, calling product search tools, and generating informed responses. You'll use specialized evaluators for Intent Resolution (did Cora understand what the customer wanted?), Tool Call Accuracy (did Cora use the right tools correctly?), and Task Adherence (did Cora follow through on the workflow?). These evaluators ensure Cora reliably delivers on customer requests throughout its multi-step reasoning process.

## 3. Instructions

!!! lab "NOTEBOOK: Evaluate Agents"

    **📓 Open:** [`labs/4-evaluation/44-evaluate-agents.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/4-evaluation/44-evaluate-agents.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Understand the unique evaluation challenges of multi-step agentic workflows
2. Use Intent Resolution Evaluator to measure whether agents correctly identify user intent
3. Use Tool Call Accuracy Evaluator to assess whether agents select and use tools correctly
4. Use Task Adherence Evaluator to measure whether agents follow through on assigned workflows
5. Apply both quality and safety evaluators to comprehensive agentic workflow assessment

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to evaluate agent tool selection and usage with the Tool Call Accuracy Evaluator
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Help me measure intent resolution to ensure my agent correctly understands customer requests
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Explain how to use Task Adherence Evaluator to validate multi-step agent workflow completion
    ```

## 5. Related Resources

- 📘 [Evaluate Generative AI Apps - Azure AI Foundry](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk#evaluate-on-test-dataset-using-evaluate)
- 📘 [Agent Evaluation Metrics and Evaluators](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in)
- 📘 [Building and Evaluating AI Agents Best Practices](https://learn.microsoft.com/azure/ai-services/agents/overview)

## 6. Key Takeaways

- Agent evaluators measure multi-step workflow performance: intent understanding, tool usage accuracy, and task completion
- Specialized agent metrics complement standard quality/safety evaluators for comprehensive agentic system assessment
- Agent evaluation requires test data that captures the full workflow context including tool calls and reasoning steps
