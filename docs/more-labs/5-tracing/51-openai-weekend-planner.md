# OpenAI Weekend Planner

!!! info "Objective"

    Instrument Azure OpenAI Agents workflow with automatic GenAI telemetry for weekend planning.

## 1. Description

This lab demonstrates automatic tracing for Azure OpenAI Agents using the `opentelemetry-instrumentation-openai-agents-v2` package. You'll instrument a simple weekend planner agent and capture telemetry without manual span creation.

## 2. Scenario

Before applying tracing to Cora, practice with a simpler agent. This weekend planner helps users organize activities, demonstrating automatic instrumentation patterns you can apply to more complex agents.

## 3. Instructions

!!! lab "NOTEBOOK: OpenAI Weekend Planner"

    **📓 Open:** [`labs/5-tracing/51-openai-weekend-planner.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/5-tracing/51-openai-weekend-planner.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Install and configure automatic OpenAI Agents instrumentation
2. Capture agent lifecycle spans automatically
3. Trace asynchronous agent operations
4. Configure telemetry capture options
5. Export traces to console or Application Insights
6. Compare automatic vs manual instrumentation

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts.

1. Ask for Guidance:

    ```title="" linenums="0"
    How do I enable automatic tracing for Azure OpenAI Agents?
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    What telemetry does opentelemetry-instrumentation-openai-agents-v2 capture?
    ```

## 5. Related Resources

- 📘 [OpenTelemetry Instrumentation for OpenAI Agents](https://pypi.org/project/opentelemetry-instrumentation-openai-agents-v2/)
- 📘 [Azure OpenAI Agents](https://learn.microsoft.com/azure/ai-services/openai/how-to/assistant)

## 6. Key Takeaways

- Automatic instrumentation reduces code changes needed for observability
- The instrumentation library handles GenAI semantic conventions automatically
- Configurable capture options control what telemetry is collected
- Automatic tracing works seamlessly with async agent operations
