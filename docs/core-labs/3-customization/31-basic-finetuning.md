# Lab 3.1: Basic Fine-tuning

!!! info "Objective"
    Fine-tune a model to achieve specific tone, format, and behavior consistent with Zava's brand requirements.

## 1. Description

Learn the fundamentals of model fine-tuning by training a model on Zava-specific examples to achieve consistent, polite customer service responses. Fine-tuning allows you to customize a base model's behavior by training it on curated examples that demonstrate your desired output style, tone, and domain expertise.

## 2. Scenario

**Cora** is Zava's customer service chatbot. While base models provide good general responses, Zava needs Cora to consistently demonstrate their brand voice: polite, factual, helpful, and focused on DIY home improvement expertise. You'll prepare training data in JSONL format, configure a fine-tuning job in Azure AI Foundry, monitor the training process, and deploy the customized model for evaluation.

## 3. Instructions

!!! lab "NOTEBOOK: Basic Fine-tuning"

    **📓 Open:** [`labs/3-customization/31-basic-finetuning.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/3-customization/31-basic-finetuning.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Prepare and validate training data in JSONL format with proper message structure
2. Analyze token counts and distribution for cost estimation and quality optimization
3. Configure and launch fine-tuning jobs using Azure AI Foundry
4. Monitor training progress and evaluate fine-tuned model performance
5. Deploy and test fine-tuned models for production use

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Guidance:

    ```title="" linenums="0"
    Show me how to format training data for fine-tuning in JSONL format with system, user, and assistant message roles
    ```

1. Ask for Explanations:

    ```title="" linenums="0"
    Help me configure hyperparameters for a fine-tuning job in Azure AI Foundry and explain their impact on model behavior
    ```

1. Ask for Specific Help:

    ```title="" linenums="0"
    Explain how to validate token counts and prepare datasets that balance quality with training costs
    ```

## 5. Related Resources

- 📘 [Fine-tune GPT Models - Azure OpenAI Service](https://learn.microsoft.com/azure/ai-services/openai/how-to/fine-tuning)
- 📘 [Prepare Training and Validation Data for Fine-tuning](https://learn.microsoft.com/azure/ai-services/openai/how-to/fine-tuning#prepare-your-training-and-validation-data)
- 📘 [Fine-tuning Considerations and Best Practices](https://learn.microsoft.com/azure/ai-services/openai/concepts/fine-tuning-considerations)

## 6. Key Takeaways

- Fine-tuning embeds specific behaviors, tone, and domain expertise directly into model weights for consistent outputs
- Training data quality matters more than quantity - aim for diverse, high-quality examples demonstrating desired behavior
- Token analysis and validation prevent costly training errors and optimize for both quality and cost efficiency
