# Core Labs

!!! info "Welcome to Core Labs"
    These hands-on exercises are designed to be completed during the in-venue instructor-led workshop session. They provide foundational knowledge and practical experience in building, evaluating, and deploying agentic AI applications on Azure AI Foundry.
    
## 1. Application Scenario

!!! quote ""
    This hands-on scenario covers the complete workflow: prototype, evaluate, customize, monitor, and deploy. See the [Workshop Outline](outline.md) for how each lab connects to this scenario.


You'll build **Cora**, an AI shopping assistant for Zava, a home improvement retailer. Cora helps customers by answering questions about products, checking inventory, and sharing available discounts.

**Your goals:**

- Build an agent that retrieves accurate product information
- Test different models to find the right balance of quality and cost
- Fine-tune responses to match the brand's helpful, polite tone
- Add tracing to monitor performance and debug issues
- Deploy the solution to production

## 2. Learning Journey

| Lab Objective | What You'll Learn |
|---------------|-------------------|
| [0: Setup & Validation](0-setup/index.md) | Validate Azure infrastructure and prepare your development environment |
| [1: Build Cora](1-agents/11-agent-service.md) | Create AI agents using Azure AI Agent Service with managed infrastructure |
| [2.1: Simulate Dataset](2-models/21-simulate-dataset.md) | Generate synthetic query-response pairs from product catalog data |
| [2.2: Evaluate Models](2-models/22-evaluate-models.md) | Compare models to select the best one for your use case |
| [3.1: Basic Fine-Tuning](3-customization/31-basic-finetuning.md) | Customize model tone and style through fine-tuning |
| [3.2: Custom Grader](3-customization/32-custom-grader.md) | Build custom evaluators to measure quality metrics |
| [3.3: Distillation](3-customization/33-distill-finetuning.md) | Transfer knowledge from larger to smaller models for cost efficiency |
| [4.1: First Evaluation](4-evaluation/41-first-evaluation.md) | Run quality and safety evaluations using built-in metrics |
| [4.4: Evaluate Agents](4-evaluation/44-evaluate-agents.md) | Measure agent performance including intent recognition and tool selection |
| [5: Trace Cora Agent](5-tracing/51-trace-cora-retail-agent.md) | Instrument agents with OpenTelemetry and export to Azure Monitor |
| [6: Deployment](6-deployment/60-deployment.md) | Deploy fine-tuned models to Azure AI Foundry for production |
| [7: Teardown](7-teardown/index.md) | Clean up resources and decommission the environment |


## 3. Getting Help

!!! question "Need Assistance?"
    - **In-venue:** Raise your hand for instructor support
    - **Post-event:** Join the [Discord Community](https://aka.ms/model-mondays/discord) to get help or share feedback
    - **Content Issues:** File issues on the [GitHub repository](https://github.com/microsoft/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure)
