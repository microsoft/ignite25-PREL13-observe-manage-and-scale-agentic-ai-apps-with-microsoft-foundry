# Tracing Cora Retail Agent

!!! info "Objective"

    Apply tracing techniques to the Cora retail agent to monitor real-world agent interactions.

## 1. Description

This lab applies the tracing concepts you've learned to the Cora retail agent. You'll instrument the agent, collect traces during customer interactions, and analyze the data to understand agent behavior.

## 2. Scenario

Now that Cora is handling customer queries, the team needs production-grade observability. This lab shows how to trace actual customer service interactions to ensure quality and performance.

## 3. Instructions

!!! lab "NOTEBOOK: Tracing Cora Retail Agent"

    **📓 Open:** [`labs/5-tracing/51-trace-cora-retail-agent.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/5-tracing/51-trace-cora-retail-agent.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Instrument the Cora agent with tracing
2. Capture customer interaction traces
3. Analyze multi-turn conversations
4. Monitor tool invocations and grounding data
5. Use traces for troubleshooting production issues

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts.

1. Ask for Guidance:

    ```title="" linenums="0"
    How do I trace a production agent handling customer queries?
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    What should I look for in agent traces to identify issues?
    ```

## 5. Related Resources

- 📘 [Production Agent Monitoring](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/trace-production-sdk)
- 📘 [Agent Telemetry Best Practices](https://learn.microsoft.com/azure/ai-foundry/concepts/trace)

## 6. Key Takeaways

- Production agents require comprehensive tracing for reliability and debugging
- Trace analysis helps identify common failure patterns and optimization opportunities
- Multi-turn conversations create complex traces that reveal agent reasoning patterns
