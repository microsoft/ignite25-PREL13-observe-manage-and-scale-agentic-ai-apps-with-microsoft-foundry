# LangChain Weekend Planner

!!! info "Objective"

    Capture LangChain agent telemetry using Azure AI OpenTelemetry tracer for weekend planning.

## 1. Description

Learn to trace LangChain agents using the `langchain-azure-ai[opentelemetry]` integration. This lab shows how Azure AI Foundry integrates with LangChain's native tracing capabilities for consistent observability.

## 2. Scenario

Many developers build agents with LangChain. This lab demonstrates how to instrument LangChain workflows with GenAI-compliant telemetry that flows seamlessly into Azure Monitor.

## 3. Instructions

!!! lab "NOTEBOOK: LangChain Weekend Planner"

    **📓 Open:** [`labs/5-tracing/52-langchain-weekend-planner.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/5-tracing/52-langchain-weekend-planner.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Install LangChain Azure AI OpenTelemetry integration
2. Configure LangChain callbacks for tracing
3. Capture chain execution spans automatically
4. Trace LangChain tool invocations
5. Export LangChain telemetry to Azure Monitor
6. Understand LangChain-specific span structure

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts.

1. Ask for Guidance:

    ```title="" linenums="0"
    How do I add OpenTelemetry tracing to a LangChain agent?
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    How do LangChain chains map to OpenTelemetry spans?
    ```

## 5. Related Resources

- 📘 [LangChain Azure AI Integration](https://python.langchain.com/docs/integrations/providers/microsoft/)
- 📘 [LangChain Tracing](https://python.langchain.com/docs/how_to/debugging/)

## 6. Key Takeaways

- LangChain's callback system enables flexible tracing integration
- Azure AI OpenTelemetry callbacks provide GenAI-compliant spans for LangChain
- Chain structure naturally maps to hierarchical span relationships
- Framework-agnostic tracing enables consistent observability across agent implementations
