# Simulate Test Datasets

## 1. Objective

Generate synthetic query-response pairs from a product catalog using Azure AI Search and the Azure AI Evaluation Simulator to create high-quality test datasets for model evaluation.

## 2. Scenario

Cora is Zava Hardware Store's customer service chatbot that helps DIY enthusiasts find the right home improvement products. Before deploying Cora to production, you need quality test data to measure her performance. Rather than manually creating hundreds of test queries, you'll use Azure AI's synthetic data generation capabilities to automatically create realistic customer queries and expected responses based on Zava's product catalog. This ensures Cora can accurately answer questions about paint, tools, hardware, and other products before customers interact with her.

## 3. Instructions

!!! lab "NOTEBOOK: Simulate Test Datasets"

    **📓 Open:** [`labs/2-models/21-simulate-dataset.ipynb`](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/blob/main/labs/2-models/21-simulate-dataset.ipynb)
    
    **🚀 Run the notebook:**
    
    1. Select the Python kernel when prompted
    2. Clear all outputs (optional, for a clean start)
    3. Run all cells sequentially

**What you'll learn in this lab:**

1. Configure Azure AI Evaluation Simulator with Azure OpenAI model configuration
2. Connect to Azure AI Search and implement product catalog retrieval functions
3. Create RAG application callback that simulates complete query-response workflow
4. Generate synthetic query-response pairs with realistic customer queries
5. Save and validate dataset in JSONL format for evaluation purposes

## 4. Ask Copilot

!!! prompt "OPTIONAL: Build Your Intuition"
    Open GitHub Copilot Chat in VS Code by pressing `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Shift+I` (Mac), then try these prompts to build your own intuition on this topic - or write your own. To copy a prompt, hover over the code block below to see the _copy to clipboard_ icon.

1. Ask for Explanations:

    ```title="" linenums="0"
    Explain the difference between generating synthetic test data with a simulator versus manually creating test queries
    ```

## 5. Related Resources

- 📘 [Generate synthetic and simulated data for evaluation](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/simulator-interaction-data)
- 📘 [Azure AI Evaluation Simulator for testing conversational applications](https://learn.microsoft.com/azure/ai-foundry/concepts/concept-synthetic-data)
- 📘 [Generative AI app developer workflow - evaluation datasets](https://learn.microsoft.com/azure/databricks/generative-ai/tutorials/ai-cookbook/genai-developer-workflow)

## 6. Key Takeaways

- Azure AI Evaluation Simulator automates creation of realistic test queries from your product catalog, eliminating manual test data creation
- RAG callback functions enable end-to-end testing by simulating the complete retrieval-augmentation-generation workflow
- JSONL format test datasets provide standardized input for comprehensive model evaluation and comparison

---

!!! note "Next Step"
    Finished generating datasets? Close the notebook and continue to model evaluation or customization as directed.

