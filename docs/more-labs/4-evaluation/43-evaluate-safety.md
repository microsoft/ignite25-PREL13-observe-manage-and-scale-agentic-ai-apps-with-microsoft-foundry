# Lab 4.3: Evaluate Safety

!!! info "Objective"
    Implement content safety evaluations to ensure your agent meets responsible AI standards.

## 1. Description

Learn to evaluate and enforce safety guardrails for hate speech, violence, sexual content, and self-harm using Azure's content safety evaluators. Safety evaluation helps you identify risks like harmful content, jailbreak attempts, and protected material violations to maintain a secure and trustworthy customer experience.

## 2. Scenario

**Before deploying Cora**, you must ensure it generates safe, appropriate content and is protected against adversarial attacks. You'll use Azure AI Foundry's safety evaluators to assess risk categories (hate, violence, sexual, self-harm, protected material, jailbreak) with severity scoring. This evaluation will help you identify potential safety issues and implement guardrails to maintain Zava's responsible AI standards.

## 3. Instructions

!!! lab "NOTEBOOK: Evaluate Safety"

    **📓 Open:** [`labs/4-evaluation/43-evaluate-safety.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/4-evaluation/43-evaluate-safety.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Understand risk and safety categories: hateful content, violent content, sexual content, self-harm, protected material, jailbreak, ungrounded attributes
2. Run individual safety evaluators with LLM-based assessment for each risk category
3. Use the Content Safety Evaluator for composite safety assessment across all categories
4. Interpret defect rates and severity scores (0-7 scale) with configurable thresholds
5. Analyze safety evaluation results to identify and mitigate potential risks

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to evaluate content safety using Azure AI with the Content Safety Evaluator
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain the different safety categories (hate, violence, sexual, self-harm) and their severity scales
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Help me configure safety thresholds and interpret defect rates in evaluation results
    ```

## 5. Related Resources

- 📘 [Risk and Safety Metrics - Azure AI Foundry](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in#risk-and-safety-metrics)
- 📘 [Content Safety Evaluator Documentation](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk#evaluate-on-test-dataset-using-evaluate)
- 📘 [Azure AI Content Safety Overview](https://learn.microsoft.com/azure/ai-services/content-safety/overview)

## 6. Key Takeaways

- Safety evaluators assess risk categories using severity scales (0-7) to identify harmful content and adversarial attacks
- Content Safety Evaluator provides composite assessment across all safety categories in a single evaluation run
- Safety evaluation is critical for responsible AI deployment and maintaining user trust in customer-facing applications
