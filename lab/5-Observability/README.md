# 5. Observability Samples

This lab focuses on adding telemetry to agent-based workflows without provisioning any new Azure resources. Each sample highlights how to adopt the [GenAI semantic conventions](https://opentelemetry.io/docs/specs/semconv/gen-ai/) so that traces captured locally can flow cleanly into Azure Monitor, Application Insights, or any OpenTelemetry-compatible backend.

## What You Will Learn

- Instrument agent lifecycles (create/invoke) using the `span.gen_ai.create_agent.client` and `span.gen_ai.invoke_agent.client` conventions.
- Capture inference spans for Azure OpenAI calls with the `span.azure.ai.inference.client` extension.
- Record tool executions that run inside your agent by emitting `span.gen_ai.execute_tool.internal` spans.
- Collect spans locally with the OpenTelemetry SDK so you can review GenAI attributes before wiring exporters into production systems.

## Folder Layout

- `01-trace-agent-session.ipynb` – walk through manual span creation for agent provisioning and invocation, including nested tool spans.
- `02-collect-span-snapshots.ipynb` – demonstrate exporting the resulting spans to in-memory and OTLP-compatible payloads that you can ship to observability backends.
- `1-OpenAIAgents/weekend_planner.ipynb` – asynchronous OpenAI Agents example with automatic GenAI span capture via `opentelemetry-instrumentation-openai-agents-v2`.
- `2-LangChain/weekend_planner.ipynb` – LangChain v1 agent instrumented with `langchain-azure-ai` callbacks to emit `invoke_agent` and tool spans.
- `3-LangGraph/music_router.ipynb` – LangGraph workflow that streams tool calls while the Azure AI tracer records compliant telemetry.

Use the notebooks as primers on the raw span payloads, then adapt the Python samples to instrument full applications.

## Required Python Packages

Install the following packages in addition to the repo-wide lab requirements:

```bash
pip install opentelemetry-instrumentation-openai-agents-v2
pip install langchain-azure-ai
```

Both packages automatically apply the GenAI semantic conventions and expose toggles for capturing system instructions, tool definitions, and message content.

## Running the Samples

1. Set the environment variables for your preferred model host (GitHub Models or Azure OpenAI). Each sample documents the required variables at the top of the file.
1. Export an `APPLICATION_INSIGHTS_CONNECTION_STRING` if you want spans to flow into Azure Monitor; otherwise the scripts fall back to console exporters so you can inspect payloads locally.
1. Open any notebook (for example, `lab/5-Observability/1-OpenAIAgents/weekend_planner.ipynb`) and run the cells in order. Observe the emitted spans and confirm that the GenAI attributes align with the semantic conventions.

Each notebook keeps infrastructure changes out of scope—you can plug the tracer providers into your existing deployments once you are satisfied with the emitted telemetry.
