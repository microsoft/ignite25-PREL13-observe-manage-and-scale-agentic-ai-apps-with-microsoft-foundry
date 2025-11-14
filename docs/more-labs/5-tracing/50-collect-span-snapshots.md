# Collect Span Snapshots

!!! info "Objective"

    Capture agent spans locally with in-memory exporter for validation before production.

## 1. Description

Learn how to collect detailed span snapshots from agent executions using in-memory exporters. This lab teaches you to capture and analyze telemetry data locally before configuring production observability backends.

## 2. Scenario

Before exporting Cora's traces to Azure Monitor, the Zava team wants to validate the trace structure and GenAI semantic conventions locally. This lab shows how to collect and inspect spans without requiring production infrastructure.

## 3. Instructions

!!! lab "NOTEBOOK: Collect Span Snapshots"

    **📓 Open:** [`labs/5-tracing/50-collect-span-snapshots.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/5-tracing/50-collect-span-snapshots.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Configure in-memory span exporters for local capture
2. Collect spans from agent operations without external dependencies
3. Inspect span structure and GenAI attributes
4. Export spans to JSON for analysis
5. Validate telemetry before production deployment
6. Debug tracing issues locally

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts.

1. Ask for Guidance:

    ```title="" linenums="0"
    How do I collect OpenTelemetry spans locally without an exporter?
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    What information is captured in an OpenTelemetry span?
    ```

## 5. Related Resources

- 📘 [OpenTelemetry Spans](https://opentelemetry.io/docs/concepts/signals/traces/#spans)
- 📘 [GenAI Semantic Conventions](https://opentelemetry.io/docs/specs/semconv/gen-ai/)

## 6. Key Takeaways

- In-memory exporters enable local span collection for development and testing
- Span snapshots provide detailed operational metrics for each agent action
- Local validation helps catch tracing issues before production deployment
- JSON export enables offline analysis and troubleshooting
