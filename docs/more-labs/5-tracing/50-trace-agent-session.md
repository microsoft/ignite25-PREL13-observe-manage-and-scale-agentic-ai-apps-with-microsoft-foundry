# Trace Agent Session

!!! info "Objective"

    Emit GenAI-compliant spans for agent creation, invocation, and tool execution workflows.

## 1. Description

This lab introduces manual span creation for agent workflows following GenAI semantic conventions. You'll learn to instrument agent lifecycle events, tool executions, and inference calls with proper OpenTelemetry spans.

## 2. Scenario

Understanding the fundamentals of GenAI tracing helps the Zava team create consistent telemetry across different agent frameworks. This lab demonstrates how to manually emit spans for agent operations.

## 3. Instructions

!!! lab "NOTEBOOK: Trace Agent Session"

    **📓 Open:** [`labs/5-tracing/50-trace-agent-session.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/5-tracing/50-trace-agent-session.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Create spans for agent creation (`gen_ai.create_agent.client`)
2. Instrument agent invocation (`gen_ai.invoke_agent.client`)
3. Trace tool execution (`gen_ai.execute_tool.internal`)
4. Add Azure OpenAI inference spans (`azure.ai.inference.client`)
5. Structure nested spans for complex workflows
6. Apply GenAI semantic conventions correctly

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to manually create OpenTelemetry spans for an AI agent
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain the GenAI semantic conventions for agent tracing
    ```

## 5. Related Resources

- 📘 [GenAI Semantic Conventions](https://opentelemetry.io/docs/specs/semconv/gen-ai/)
- 📘 [OpenTelemetry Python SDK](https://opentelemetry.io/docs/languages/python/)

## 6. Key Takeaways

- GenAI semantic conventions provide standardized span names and attributes for AI operations
- Manual span creation offers fine-grained control over telemetry capture
- Proper span nesting represents execution hierarchy and dependencies
- Consistent conventions enable cross-framework observability
