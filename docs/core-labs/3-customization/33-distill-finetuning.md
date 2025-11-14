# Lab 3.3: Distillation Fine-tuning

!!! info "Objective"
    Learn to use model distillation to create cost-efficient models that maintain quality while reducing operational costs.

## 1. Description

Explore model distillation by using a larger, more capable "teacher" model's outputs to train a smaller, faster, and more cost-effective "student" model. Distillation enables knowledge transfer from expensive models to efficient ones, achieving significant cost and performance improvements while maintaining quality standards for specialized tasks.

## 2. Scenario

**Cora is using GPT-4** for excellent customer service quality, but the costs are high for Zava's scale. You'll implement model distillation to transfer Cora's specialized knowledge from GPT-4 (teacher) to GPT-4.1-nano (student). This process captures GPT-4's stored completions, uses them as training data, and fine-tunes the smaller model to achieve comparable quality at a fraction of the cost and latency.

## 3. Instructions

!!! lab "NOTEBOOK: Distillation Fine-tuning"

    **📓 Open:** [`labs/3-customization/33-distill-finetuning.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/3-customization/33-distill-finetuning.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Understand teacher-student architecture and knowledge transfer concepts in model distillation
2. Configure distillation pipelines using Azure AI Foundry evaluation and fine-tuning services
3. Use custom graders to measure baseline and distilled model performance
4. Generate training data from teacher model completions for student model learning
5. Compare cost, speed, and quality tradeoffs between different model sizes

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Explain how model distillation works with teacher-student architecture and when to use it versus fine-tuning or prompt engineering
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Show me how to generate training data from GPT-4 stored completions for distilling knowledge to GPT-4.1-nano
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Help me compare the cost, latency, and quality tradeoffs between teacher and student models using evaluation metrics
    ```

## 5. Related Resources

- 📘 [Model Distillation Overview - Azure AI Foundry](https://learn.microsoft.com/azure/ai-studio/concepts/model-distillation)
- 📘 [Stored Completions for Fine-tuning and Distillation](https://learn.microsoft.com/azure/ai-services/openai/how-to/stored-completions)
- 📘 [Fine-tuning with Distilled Data from Teacher Models](https://learn.microsoft.com/azure/ai-services/openai/concepts/fine-tuning-considerations#distillation)

## 6. Key Takeaways

- Distillation transfers specialized knowledge from large teacher models to small student models, achieving cost/performance gains
- Stored completions from teacher models provide high-quality training data that embeds the teacher's capabilities
- Custom graders validate that distilled models maintain quality standards while delivering dramatic improvements in cost and speed
