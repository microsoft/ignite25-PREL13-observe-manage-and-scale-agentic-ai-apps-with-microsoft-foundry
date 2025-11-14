# LangGraph Music Router

!!! info "Objective"

    Stream LangGraph workflow with tool routing and GenAI telemetry for music playback control.

## 1. Description

Explore tracing for LangGraph agents with stateful workflows and conditional routing. This lab demonstrates how to instrument complex graph-based agents that use state machines and branching logic.

## 2. Scenario

LangGraph enables sophisticated agent workflows with state management and conditional routing. This music recommendation router demonstrates tracing patterns for complex, stateful agent architectures.

## 3. Instructions

!!! lab "NOTEBOOK: LangGraph Music Router"

    **📓 Open:** [`labs/5-tracing/53-langgraph-music_router.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/5-tracing/53-langgraph-music_router.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Trace LangGraph stateful workflows
2. Capture conditional routing decisions in spans
3. Track state transitions across agent steps
4. Instrument streaming graph execution
5. Analyze branching execution paths in traces
6. Debug complex graph-based agent logic

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts.

1. Ask for Guidance:

    ```title="" linenums="0"
    How do I add tracing to a LangGraph stateful workflow?
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    How are LangGraph state machines represented in OpenTelemetry traces?
    ```

## 5. Related Resources

- 📘 [LangGraph Documentation](https://langchain-ai.github.io/langgraph/)
- 📘 [LangGraph Tracing](https://langchain-ai.github.io/langgraph/how-tos/tracing/)

## 6. Key Takeaways

- LangGraph's graph structure creates hierarchical traces mirroring the state machine
- Conditional routing appears as branching paths in trace visualizations
- State transitions can be captured as span attributes for debugging
- Streaming execution maintains trace context across async operations
- Complex agent workflows benefit significantly from detailed tracing
