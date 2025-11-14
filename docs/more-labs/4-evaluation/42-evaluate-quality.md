# Lab 4.2: Evaluate Quality

!!! info "Objective"
    Assess response quality using groundedness, relevance, coherence, and fluency metrics.

## 1. Description

Dive deep into quality evaluation metrics to measure how well your agent provides accurate, relevant, and well-structured responses. Azure AI Foundry provides built-in quality evaluators that use AI-assisted workflows with LLM judges to assess multiple dimensions of response quality on Likert scales.

## 2. Scenario

**Cora must provide high-quality responses** about Zava's home improvement products that are grounded in factual information, relevant to customer queries, coherent in structure, and fluent in language. You'll explore individual quality evaluators (groundedness, relevance, coherence, fluency, similarity) and composite evaluators that assess multiple metrics simultaneously to ensure Cora meets production quality standards.

## 3. Instructions

!!! lab "NOTEBOOK: Evaluate Quality"

    **📓 Open:** [`labs/4-evaluation/42-evaluate-quality.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/4-evaluation/42-evaluate-quality.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Understand AI-assisted evaluation workflows with LLM judges for quality assessment
2. Use individual quality evaluators for groundedness, relevance, coherence, fluency, and similarity
3. Run composite evaluators to assess multiple quality dimensions simultaneously
4. Interpret quality metrics on Likert scales (1-5) with configurable pass/fail thresholds
5. Analyze quality evaluation results to identify areas for model or prompt improvement

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Explain the difference between groundedness and relevance metrics in quality evaluation
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Show me how to measure coherence and fluency in AI responses using composite evaluators
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Help me interpret quality evaluation results and identify which metrics indicate the biggest quality issues
    ```

## 5. Related Resources

- 📘 [Generation Quality Metrics - Azure AI Foundry](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in#generation-quality-metrics)
- 📘 [Quality Evaluators in Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk#evaluate-on-test-dataset-using-evaluate)
- 📘 [AI-Assisted Evaluation with LLM Judges](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-approach-gen-ai)

## 6. Key Takeaways

- Quality evaluators measure multiple dimensions: groundedness (factual accuracy), relevance (query alignment), coherence (structure), fluency (language)
- AI-assisted evaluation uses LLM judges to provide nuanced quality assessments beyond simple keyword matching
- Composite evaluators enable comprehensive quality measurement in a single evaluation run for efficient testing
