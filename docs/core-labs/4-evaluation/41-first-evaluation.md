# Lab 4.1: First Evaluation

!!! info "Objective"
    Run your first evaluation to understand the Azure AI evaluation workflow and metrics.

## 1. Description

Introduction to Azure AI's evaluation capabilities. Learn the basics of running evaluations, configuring built-in evaluators for quality and safety, and interpreting results. The `evaluate()` function from the Azure AI Evaluation SDK enables you to assess your AI application's performance systematically using a rich set of built-in metrics.

## 2. Scenario

**Before deploying Cora** to serve Zava customers, you need to ensure it provides accurate, safe, and helpful responses. You'll run your first evaluation using a small test dataset with 5 customer queries about home improvement products. This evaluation will use built-in quality and safety evaluators to generate metrics, save results to a file, and view them in the Azure AI Foundry portal.

## 3. Instructions

!!! lab "NOTEBOOK: First Evaluation Run"

    **📓 Open:** [`labs/4-evaluation/41-first-evaluation-run.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/4-evaluation/41-first-evaluation-run.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Understand what the `evaluate()` function does and how to configure it
2. Run evaluations with built-in quality and safety evaluators on test datasets
3. Interpret evaluation metrics including Likert scale scores and pass/fail thresholds
4. Save evaluation results to JSONL files for analysis and comparison
5. View evaluation results in the Azure AI Foundry portal for visualization

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Specific Help:

    ```title="" linenums="0"
    Explain how to interpret evaluation metrics and view results in the Azure AI Foundry portal
    ```

## 5. Related Resources

- 📘 [Evaluation and Monitoring Metrics - Azure AI Foundry](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in)
- 📘 [Evaluate with Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk)
- 📘 [Evaluation Quickstart Guide](https://learn.microsoft.com/azure/ai-studio/how-to/evaluate-generative-ai-app)

## 6. Key Takeaways

- The evaluate() function provides a systematic way to assess AI application quality and safety using built-in evaluators
- Evaluation metrics use Likert scales (1-5) with configurable thresholds to identify quality and safety issues
- Azure AI Foundry portal provides visualization and tracking capabilities for comparing evaluation runs over time

---

!!! note "Next Step"
    After reviewing evaluation metrics, close the notebook and move to the next evaluation or tracing lab.