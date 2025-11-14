# Evaluate and Compare Models

!!! info "Objective"

    Evaluate multiple Azure OpenAI models (GPT-4o, GPT-4o-mini, GPT-4) using standardized test datasets and compare their performance across quality, safety, and latency metrics.

## 1. Description

Learn to conduct pre-production model evaluation using Azure AI Foundry's built-in evaluators. This lab covers configuring multiple Azure OpenAI models, loading standardized test datasets, running comprehensive evaluations measuring quality metrics (relevance, coherence, fluency) and safety metrics (violence, hate, self-harm, sexual content), and analyzing results to make data-driven model selection decisions.

## 2. Scenario

Zava's leadership wants to ensure Cora provides the best customer experience possible while managing cloud costs effectively. With multiple Azure OpenAI models available—from the cost-effective GPT-4o-mini to the more capable GPT-4—you need to determine which model strikes the right balance for Zava's retail use case. By systematically evaluating each model's response quality, safety compliance, and processing speed using real customer queries about hardware products, you'll provide data-driven recommendations on which model delivers accurate product information while maintaining appropriate safety standards for Zava's family-friendly customer base.

## 3. Instructions

!!! lab "NOTEBOOK: Evaluate and Compare Models"

    **📓 Open:** [`labs/2-models/22-evaluate-models.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/2-models/22-evaluate-models.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Configure multiple model deployments for GPT-4o, GPT-4o-mini, and GPT-4
2. Load standardized test datasets in JSONL format for consistent testing
3. Initialize built-in evaluators for quality (relevance, coherence, fluency) and safety
4. Run comprehensive evaluations and publish results to Azure AI Foundry portal
5. Analyze and compare results to inform model selection decisions

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to evaluate multiple Azure OpenAI models side-by-side using the Azure AI Evaluation SDK and publish results to the Foundry portal
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain the difference between AI-assisted quality evaluators like relevance and coherence versus content safety evaluators
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Help me add custom evaluation criteria to measure product recommendation accuracy for our hardware retail chatbot
    ```

## 5. Related Resources

- 📘 [Evaluate generative AI models and applications in Azure AI Foundry](https://learn.microsoft.com/azure/ai-foundry/how-to/evaluate-generative-ai-app)
- 📘 [Azure AI Evaluation SDK - built-in evaluators](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/evaluate-sdk)
- 📘 [Monitor quality and safety of deployed applications](https://learn.microsoft.com/azure/ai-foundry/how-to/monitor-quality-safety)

## 6. Key Takeaways

- Azure AI Foundry's built-in evaluators provide standardized quality and safety metrics for objective model comparison
- Side-by-side evaluation reveals performance trade-offs between cost-effective and premium models for specific use cases
- Publishing evaluation results to Azure AI Foundry portal enables team collaboration and historical comparison of model performance
