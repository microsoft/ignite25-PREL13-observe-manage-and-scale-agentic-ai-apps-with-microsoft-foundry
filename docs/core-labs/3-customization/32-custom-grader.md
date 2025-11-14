# Lab 3.2: Custom Grader

!!! info "Objective"
    Create domain-specific evaluators to measure custom quality metrics for your agentic AI application.

## 1. Description

Build custom evaluators that assess qualities beyond standard metrics, such as brand voice consistency, politeness, or business rule compliance. Custom graders enable you to define specific evaluation criteria that align with your business requirements and ensure consistent quality measurement across model iterations.

## 2. Scenario

**Zava needs custom quality metrics** that go beyond standard relevance and coherence scores. You'll create a custom grader to evaluate Cora's responses for politeness, brand voice consistency, and adherence to Zava's customer service guidelines. This grader will establish "gold standard" baseline responses, define clear grading criteria, and provide consistent evaluation for model optimization and distillation workflows.

## 3. Instructions

!!! lab "NOTEBOOK: Custom Grader"

    **📓 Open:** [`labs/3-customization/32-custom-grader.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/3-customization/32-custom-grader.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Design custom evaluator functions using Python and Azure AI evaluation SDK
2. Define domain-specific scoring criteria with clear rubrics and thresholds
3. Curate baseline "gold standard" examples for consistent evaluation
4. Integrate custom evaluators into model assessment workflows
5. Validate grader reliability and consistency across different model outputs

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to create a custom evaluator function using the AzureOpenAIPythonGrader class for measuring politeness in responses
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Help me define scoring criteria and rubrics for brand voice consistency with specific score thresholds
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Explain how to validate that my custom grader produces consistent and reliable evaluation results
    ```

## 5. Related Resources

- 📘 [Custom Evaluators in Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk#custom-evaluators)
- 📘 [AzureOpenAIPythonGrader Class Documentation](https://learn.microsoft.com/python/api/azure-ai-evaluation/azure.ai.evaluation.azureopenaipythongrader)
- 📘 [Evaluation Metrics and Custom Grading Logic](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in)

## 6. Key Takeaways

- Custom evaluators enable measurement of business-specific quality attributes that standard metrics cannot capture
- Well-defined grading criteria with clear rubrics ensure consistent and reliable evaluation across model iterations
- Gold standard baseline examples provide reference points for validating grader accuracy and model performance
