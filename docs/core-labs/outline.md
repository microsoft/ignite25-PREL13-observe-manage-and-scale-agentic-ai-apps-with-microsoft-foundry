# Workshop Outline: Building Cora for Zava

This workshop teaches you to build, evaluate, and deploy **Cora**, an AI shopping assistant for Zava Hardware Store. You'll learn the complete AI development lifecycle through hands-on labs that solve real business challenges.

---

## 1. The Zava Business Challenge

Zava is a home improvement retailer selling paint, power tools, hand tools, hardware, electrical supplies, and plumbing materials. They want to build **Cora**, a customer service chatbot that:

- Answers product questions accurately
- Checks inventory in real-time
- Calculates personalized discounts based on customer loyalty
- Maintains a helpful, polite brand voice
- Operates cost-effectively at scale

**Success Criteria:**
- Fast, accurate responses grounded in product data
- Safe, appropriate interactions with all customers
- Reliable performance under production load
- Measurable quality and safety metrics

This workshop walks you through building Cora from prototype to production.

---

## [2. Lab 0: Setup](0-setup/index.md)

**Objective:** To build Cora, you need a working Azure environment with all required services.

**What You'll Do:** 

- Validate Azure AI Foundry project setup
- Confirm model deployments are accessible
- Verify environment variables are configured
- Test connectivity to Azure services (OpenAI, Search, Monitor)

**What You Learn:** 

- Azure AI Foundry project structure
- Required services for agentic AI development
- Environment configuration best practices

**Next:**  With infrastructure validated, you're ready to build your first agent.

---

## [3. Lab 1: Build Agent](1-agents/11-agent-service.md)

**Objective:** Customers ask questions like "What paint do you have?" or "Do you have any power drills in stock?" Cora needs to understand these questions, search the product catalog, and provide helpful answers.

**What You'll Do:**

- Create Cora using Azure AI Agent Service
- Load Zava's 50+ product catalog as knowledge base
- Define Cora's personality and instructions (helpful, polite tone)
- Create conversation threads for multi-turn dialogue
- Test Cora with customer queries

**What You Learn:**

- What makes an agent different from a basic chatbot
- How agents autonomously invoke tools to complete tasks
- Conversation management with threads, messages, and runs
- When to use managed services vs. custom frameworks

**Next:** Cora works, but which AI model should power it? You need to compare options for quality, cost, and speed.

---

## [4. Lab 2.1: Generate Test Data](2-models/21-simulate-dataset.md)

**Objective:** To evaluate which model is best for Cora, you need realistic test data. Manually creating hundreds of query-response pairs is time-consuming and expensive.

**What You'll Do:**

- Use Azure AI Evaluation Simulator to generate synthetic datasets
- Connect to Azure AI Search product index
- Create query-response pairs from product catalog
- Save evaluation dataset in JSONL format
- Review generated test cases for realism

**What You Learn:**

- Why synthetic data is valuable for evaluation
- How RAG improves response accuracy by grounding in real data
- JSONL format for evaluation datasets
- Techniques for generating domain-specific test cases

**Next:** With test data ready, compare different models to find the best fit.

---

## [5. Lab 2.2: Compare Models](2-models/22-evaluate-models.md)

**Objective:** Should Cora use GPT-4o (better quality but slower/pricier), GPT-4o-mini (faster and cheaper), or GPT-4.1 (balanced)? You need objective metrics to decide.

**What You'll Do:**

- Configure multiple Azure OpenAI models for comparison
- Run evaluations using your synthetic dataset
- Measure quality metrics (groundedness, relevance, coherence)
- Compare latency and cost implications
- Use Azure AI Foundry leaderboards for additional insights

**What You Learn:**

- Model selection criteria (task complexity, cost, latency, accuracy)
- How to run systematic evaluations
- Interpreting quality metrics to make informed decisions
- Cost calculation at scale (tokens per query × queries per day)

**Next:** You've selected a model, but Cora's responses need to match Zava's specific brand voice and terminology.

---

## [6. Lab 3.1: Fine-Tuning](3-customization/31-basic-finetuning.md)

**Objective:** Generic models don't capture Zava's friendly, helpful tone or home improvement terminology. Cora says "We have paint" instead of "Great question! Let me help you find the perfect paint for your project."

**What You'll Do:**

- Prepare training data in JSONL format (query-response pairs)
- Create a fine-tuning job in Azure AI Foundry
- Monitor training progress
- Deploy the fine-tuned model
- Compare base vs. fine-tuned responses

**What You Learn:**

- When fine-tuning is better than prompt engineering
- Data preparation requirements (format, quality, quantity)
- Fine-tuning job lifecycle (submit, monitor, deploy)
- Trade-offs: improved quality vs. training cost/time

**Next:** Fine-tuning improved tone, but you need custom metrics to measure specialized quality aspects.

---

## [7. Lab 3.2: Custom Evaluators](3-customization/32-custom-grader.md)

**Objective:** Standard metrics (relevance, coherence) don't measure everything that matters to Zava. Does Cora recommend appropriate products? Does it handle out-of-stock items gracefully?

**What You'll Do:**

- Define custom evaluation criteria (product appropriateness, inventory handling)
- Create a custom grader using an LLM as judge
- Write evaluation prompts with scoring rubrics
- Run evaluations with your custom metrics
- Compare custom vs. built-in metric results

**What You Learn:**

- When built-in metrics aren't sufficient
- How to design evaluation criteria and rubrics
- LLM-as-judge implementation patterns
- Balancing automation with human review

**Next:** Fine-tuned models work well but are expensive to run at scale. Can you get similar quality from a smaller, cheaper model?

---

## [8. Lab 3.3: Distillation](3-customization/33-distill-finetuning.md)

**Objective:** Your fine-tuned GPT-4o provides great responses but costs $X per 1000 queries. At 50,000 queries/day, this adds up quickly. Can you maintain quality at lower cost?

**What You'll Do:**

- Generate training data from your fine-tuned model (teacher)
- Train a smaller model (student) to mimic teacher behavior
- Compare student vs. teacher performance
- Measure quality retention and cost savings
- Calculate ROI for production deployment

**What You Learn:**

- When distillation makes sense economically
- How to create distillation datasets
- Quality vs. cost trade-off analysis
- Techniques for maintaining performance in smaller models

**Next:** Cora is customized and cost-optimized. Now you need systematic quality and safety checks before production.

---

## [9. Lab 4.1: Quality & Safety](4-evaluation/41-first-evaluation.md)

**Objective:** Before deploying Cora to customers, you must ensure responses are accurate (grounded in facts), relevant (address questions), and safe (no harmful content).

**What You'll Do:**

- Configure Azure AI Evaluation SDK
- Run built-in quality evaluators (groundedness, relevance, coherence, fluency)
- Run safety evaluators (hate speech, violence, self-harm detection)
- Save results to JSONL for analysis
- View results in Azure AI Foundry portal

**What You Learn:**

- The three stages of GenAIOps evaluation (base model, pre-production, post-production)
- Key quality metrics and what they measure
- Content safety categories and risk levels
- How to interpret evaluation scores for deployment decisions

**Next:** Standard evaluations look good, but agents have unique challenges around tool usage and multi-step reasoning.

---

## [10. Lab 4.4: Agent Evaluation](4-evaluation/44-evaluate-agents.md)

**Objective:** Cora doesn't just generate text—it decides which tools to call, interprets results, and handles multi-turn conversations. Standard evaluations don't capture agent-specific behaviors.

**What You'll Do:**

- Measure intent recognition accuracy (understanding customer requests)
- Evaluate tool selection correctness (choosing right tool for task)
- Test conversation management (context retention across turns)
- Assess error handling (graceful failure when tools return no results)
- Create agent-specific test cases

**What You Learn:**

- How agent evaluation differs from LLM evaluation
- Measuring autonomous decision-making quality
- Testing multi-turn conversation coherence
- Evaluating tool integration reliability

**Next:** Evaluations show Cora is ready, but you need production observability to monitor real customer interactions.

---

## [11. Lab 5: Tracing](5-tracing/51-trace-cora-retail-agent.md)

**Objective:** In production, you need to understand how Cora processes requests. When a customer complaint arrives, you must see exactly what happened: which tools were called, what they returned, and how the response was generated.

**What You'll Do:**

- Instrument Cora with OpenTelemetry
- Capture GenAI-compliant spans following semantic conventions
- Track agent lifecycle events (create, run, complete)
- Monitor tool invocations and results
- Export traces to Azure Monitor Application Insights
- Query and visualize traces in the Azure portal

**What You Learn:**

- OpenTelemetry fundamentals (traces, spans, attributes)
- GenAI semantic conventions for AI-specific telemetry
- How to instrument agents for observability
- Troubleshooting production issues using traces
- Performance monitoring and optimization

**Next:** With monitoring in place, deploy your fine-tuned model to production.

---

## [12. Lab 6: Deployment](6-deployment/60-deployment.md)

**Objective:** Your fine-tuned model exists in Azure but isn't accessible to applications yet. You need to deploy it with appropriate capacity, configure monitoring, and plan rollout strategies.

**What You'll Do:**

- Deploy fine-tuned model to Azure AI Foundry
- Configure deployment settings (PTUs vs. pay-per-use)
- Update Cora to use the production deployment
- Set up monitoring and alerts
- Test production endpoint
- Review deployment best practices (blue-green, canary)

**What You Learn:**

- Model deployment lifecycle (fine-tune → deploy → serve)
- Capacity planning strategies (PTUs vs. pay-per-use)
- Deployment patterns (blue-green, canary rollouts)
- Production monitoring and alerting
- Rollback procedures for safe updates

**Next:** Clean up resources to avoid unnecessary costs.

---

## [13. Lab 7: Teardown](7-teardown/index.md)

**Objective:** Azure resources incur costs even when idle. Properly decommissioning resources prevents unexpected charges.

**What You'll Do:**

- Document important resource IDs and configurations
- Export evaluation results and traces for future reference
- Delete resource groups and associated resources
- Verify cleanup completion
- Review cost management best practices

**What You Learn:**

- Azure resource lifecycle management
- Cost optimization strategies
- Data retention and backup considerations
- Cleanup automation options

---

## 14. Workshop Summary

You've completed the full AI agent development lifecycle:

1. **Built** Cora using Azure AI Agent Service with product knowledge
2. **Generated** synthetic test data from your product catalog
3. **Compared** models to find the optimal balance of quality and cost
4. **Customized** through fine-tuning to match brand voice
5. **Created** custom evaluators for domain-specific quality metrics
6. **Distilled** knowledge to smaller models for cost efficiency
7. **Evaluated** quality, safety, and agent-specific behaviors
8. **Instrumented** with tracing for production observability
9. **Deployed** to production with appropriate monitoring

### **Key Takeaways:**
- Agentic AI requires more than prompt engineering—systematic evaluation, customization, and monitoring are essential
- Model selection balances task complexity, cost, latency, and accuracy requirements
- Fine-tuning and distillation optimize for domain-specific performance and cost
- Evaluation must cover quality, safety, and agent-specific behaviors
- Production observability with OpenTelemetry enables troubleshooting and optimization

### **Next Steps:**
- Explore optional "More Labs" for advanced topics 
- Apply these patterns to your own use cases
- Join the Azure AI community for continued learning
