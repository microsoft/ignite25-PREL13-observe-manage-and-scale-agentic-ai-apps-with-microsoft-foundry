# Observing, Managing, and Scaling Agentic AI Applications - For ZAVA

This document introduces the key concepts covered in the PREL13 workshop through the lens of a practical application scenario. As you work through the labs, you'll apply these concepts to build, evaluate, and deploy a production-ready agentic AI solution.

---

## Table of Contents

1. [Application Scenario: Zava Enterprise Retailer](#1-application-scenario-zava-enterprise-retailer)
2. [Agentic AI: Multi-Agent Systems](#2-agentic-ai-multi-agent-systems)
   - 2.1 [What is Agentic AI?](#21-what-is-agentic-ai)
   - 2.2 [Multi-Agent Architecture](#22-multi-agent-architecture)
   - 2.3 [Zava's Three-Agent Architecture](#23-zavas-three-agent-architecture)
   - 2.4 [Orchestration Patterns](#24-orchestration-patterns)
3. [Azure AI Agent Service](#3-azure-ai-agent-service)
   - 3.1 [What is Azure AI Agent Service?](#31-what-is-azure-ai-agent-service)
   - 3.2 [Why Use Azure AI Agent Service?](#32-why-use-azure-ai-agent-service)
   - 3.3 [Zava's Implementation](#33-zavas-implementation)
4. [Microsoft Agent Framework](#4-microsoft-agent-framework)
   - 4.1 [What is Microsoft Agent Framework?](#41-what-is-microsoft-agent-framework)
   - 4.2 [Core Concepts](#42-core-concepts)
   - 4.3 [When to Use Agent Framework vs. Agent Service?](#43-when-to-use-agent-framework-vs-agent-service)
   - 4.4 [Zava's Implementation](#44-zavas-implementation)
5. [Model Management and Development Lifecycle](#5-model-management-and-development-lifecycle)
   - 5.1 [The AI Development Lifecycle](#51-the-ai-development-lifecycle)
   - 5.2 [Model Selection](#52-model-selection)
   - 5.3 [Model Customization](#53-model-customization)
   - 5.4 [Deployment Types](#54-deployment-types)
   - 5.5 [Zava's Model Strategy](#55-zavas-model-strategy)
6. [Observability: Evaluation, Tracing, and Monitoring](#6-observability-evaluation-tracing-and-monitoring)
   - 6.1 [The Three Stages of GenAIOps](#61-the-three-stages-of-genaiops)
   - 6.2 [Evaluation Metrics](#62-evaluation-metrics)
   - 6.3 [Continuous Evaluation for Agents](#63-continuous-evaluation-for-agents)
   - 6.4 [Agent Evaluation in the Playground](#64-agent-evaluation-in-the-playground)
   - 6.5 [Tracing](#65-tracing)
   - 6.6 [Red Teaming](#66-red-teaming)
   - 6.7 [Zava's Observability Strategy](#67-zavas-observability-strategy)
7. [Governance Strategies](#7-governance-strategies)
   - 7.1 [What is AI Governance?](#71-what-is-ai-governance)
   - 7.2 [Key Governance Pillars](#72-key-governance-pillars)
   - 7.3 [Safety & Responsible AI](#73-safety-responsible-ai)
   - 7.4 [Zava's Governance Guidance](#74-zavas-governance-guidance)

---

## 1. Application Scenario: Zava Enterprise Retailer

**Business Context:**  
Zava is an enterprise retailer of home-improvement goods for DIY enthusiasts. They operate physical and online stores for customer shopping and want to build a _customer service chatbot_ to unlock business value by improving sales and customer loyalty.  It should:
 - help customers find the right product for their needs (Support Agent)
 - provide technical information and alternatives for out-of-stock items (Inventory Agent)
 - recommend discounts based on customer history, inventory and cart (Loyalty Agent)

**Key Requirements:**
- **Helpful Tone:** Respond in polite, helpful manner with desired Zava brand format.
- **Factual Information:** Provide information grounded in product catalog data.
- **Cost Effectiveness:** Optimize model operating costs to match task complexity.
- **Complex Discounts:** Compute discount for specific customer, cart and inventory.
- **Scalability:** Manage varying customer volumes in trustworthy, reliable manner.

**Business Value:**
- Reduce customer service response times, grow store sales
- Improve customer satisfaction through consistent, accurate support
- Lower operational costs compared to human-only support
- Scale support operations without proportional cost increases

In this workshop, you will implement _a subset of these elements_ given the time constraints. However, you should be able to build your understanding and intution for the tools, platform and end-to-end workflow in a manner that helps you explore the other ideas on your own.

By the end, you should know how to plan, develop, evaluate, customize, and deploy, agentic AI applications on Azure AI Foundry - and gain a reusable sandbox for more experimentation.

<br/>

---

## 2. Agentic AI: Multi-Agent Systems

### 2.1 What is Agentic AI?

Agentic AI refers to autonomous AI systems that can reason, plan, and take actions to accomplish goals. Unlike traditional chatbots that follow scripted responses, agentic AI systems can:

- **Reason** about complex problems by breaking them down into smaller tasks
- **Plan** sequences of actions to achieve specific objectives
- **Use tools** to access external data, perform calculations, or interact with systems
- **Adapt** their approach based on context and feedback

### 2.2 Multi-Agent Architecture

Rather than building a single monolithic agent, modern AI applications often use **multi-agent orchestration** where specialized agents work together. This approach provides:

1. **Specialization:** Each agent focuses on a specific domain, reducing complexity
2. **Scalability:** Agents can be added or modified independently
3. **Maintainability:** Testing and debugging individual agents is simpler
4. **Optimization:** Each agent can use the most appropriate model and tools

### 2.3 Zava's Three-Agent Architecture

Zava's customer support solution uses three specialized agents:

#### 1. Customer QA Agent (Polite & Helpful)
- **Purpose:** Handle general customer inquiries with a friendly, professional tone
- **Capabilities:** Answer questions about products, orders, policies
- **Tone:** Polite, empathetic, and helpful
- **Example:** "I'd be happy to help you find information about our return policy."

#### 2. Inventory Agent (Technical Information)
- **Purpose:** Provide accurate technical product information and stock availability
- **Capabilities:** Access real-time inventory data, suggest alternatives for out-of-stock items
- **Tone:** Precise and informative
- **Example:** "The blue winter jacket (SKU: WJ-2024-BL) is currently out of stock. However, we have a similar navy option available in sizes M-XL."

#### 3. Loyalty Agent (Customer Information)
- **Purpose:** Manage customer accounts and provide personalized offers
- **Capabilities:** Access customer history, loyalty points, provide contextual discounts
- **Tone:** Personalized and reward-focused
- **Example:** "As a Gold member with 2,500 points, you qualify for 15% off this purchase!"

### 2.4 Orchestration Patterns

These agents can work together using different patterns:
- **Sequential:** One agent hands off to another (QA → Inventory → Loyalty)
- **Concurrent:** Multiple agents analyze the same request in parallel
- **Hierarchical:** A coordinator agent delegates to specialized sub-agents

**Related Resources:**
- [AI Agent Orchestration Patterns](https://learn.microsoft.com/azure/architecture/ai-ml/guide/ai-agent-design-patterns)
- [Build Collaborative Multi-Agent Systems with Connected Agents](https://learn.microsoft.com/azure/ai-foundry/agents/how-to/connected-agents)
- [Transparency Note for Azure Agent Service](https://learn.microsoft.com/azure/ai-foundry/responsible-ai/agents/transparency-note)


<br/>

---

## 3. Azure AI Agent Service

### 3.1 What is Azure AI Agent Service?

Azure AI Agent Service is a production-ready platform for deploying intelligent agents in enterprise environments. It provides managed infrastructure for building, deploying, and scaling AI agents without managing the underlying complexity.

**Key Features:**

1. **Conversation Management:** Full access to structured threads including user↔agent and agent↔agent messages
2. **Multi-Agent Coordination:** Built-in support for agent-to-agent communication
3. **Tool Orchestration:** Server-side execution and retry of tool calls with structured logging
4. **Trust & Safety:** Integrated content filters to prevent misuse and mitigate risks
5. **Enterprise Integration:** Bring your own storage, search indexes, and virtual networks
6. **Observability:** Threads, tool invocations, and messages are fully traceable
7. **Identity & Policy Control:** Built on Microsoft Entra with RBAC, audit logs, and conditional access

### 3.2 Why Use Azure AI Agent Service?

- **Production-Ready:** Enterprise-grade infrastructure with SLAs
- **Simplified Development:** No need to build custom orchestration logic
- **Scalability:** Automatic scaling to handle varying workloads
- **Security:** Built-in compliance and security controls
- **Monitoring:** Integrated telemetry and Application Insights support

### 3.3 Zava's Implementation

For Zava's customer support chatbot, Azure AI Agent Service provides:

- **Persistent Conversations:** Customer support threads are stored and can be resumed
- **Agent Coordination:** The three agents (QA, Inventory, Loyalty) communicate seamlessly
- **Tool Integration:** Agents access product databases, inventory systems, and CRM
- **Safety Controls:** Content filters prevent inappropriate responses
- **Audit Trail:** All customer interactions are logged for compliance

**Example Flow:**
1. Customer asks: "Do you have winter jackets in blue?"
2. QA Agent receives the query and recognizes it needs inventory information
3. QA Agent delegates to Inventory Agent
4. Inventory Agent checks stock and suggests alternatives if needed
5. Loyalty Agent adds personalized discount if applicable
6. QA Agent synthesizes the response with polite, helpful tone

**Related Resources:**
- [What is Azure AI Foundry Agent Service?](https://learn.microsoft.com/azure/ai-foundry/agents/overview)
- [Build Collaborative Multi-Agent Systems (C#)](https://learn.microsoft.com/azure/ai-foundry/agents/how-to/connected-agents)
- [Trace and Observe AI Agents in Azure AI Foundry](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/trace-agents-sdk)


<br/>

---

## 4. Microsoft Agent Framework

### 4.1 What is Microsoft Agent Framework?

Microsoft Agent Framework is an open-source SDK (Python, .NET, JavaScript) that provides a flexible, framework-agnostic approach to building AI agents. Unlike Azure AI Agent Service which is a managed service, the Agent Framework gives you full control over agent implementation.

**Key Characteristics:**

1. **AI-Agnostic:** Works with any AI service (Azure OpenAI, Azure AI, OpenAI, local models)
2. **Flexible Deployment:** Deploy to Microsoft 365 Copilot, Teams, web apps, or custom channels
3. **Lightweight:** Minimal abstractions, maximum control
4. **Interoperable:** Supports A2A (Agent-to-Agent) protocol for agent communication

### 4.2 Core Concepts

- **Turn:** A unit of work (single message or series of messages)
- **Activity:** A type of unit managed by the agent
- **State Management:** Built-in storage and context handling
- **Chat Client Protocol:** Standardized interface for AI service integration

### 4.3 When to Use Agent Framework vs. Agent Service?

| Use Agent Framework When: | Use Agent Service When: |
|---------------------------|-------------------------|
| You need maximum flexibility | You want managed infrastructure |
| You're deploying to custom channels | You're building production agents quickly |
| You want to use non-Azure AI services | You need enterprise-grade SLAs |
| You need fine-grained control | You want simplified operations |

### 4.4 Zava's Implementation

Zava might use Agent Framework for:

- **Prototyping:** Quickly test different AI services and models
- **Custom Tools:** Build specialized inventory lookup tools
- **Integration:** Connect to existing internal systems
- **Local Development:** Test agent logic before deploying to Agent Service

**Example: Creating a Simple Agent**

```python
from agent_framework.azure import AzureOpenAIChatClient
from azure.identity import AzureCliCredential

# Create agent with Azure OpenAI
agent = AzureOpenAIChatClient(
    credential=AzureCliCredential()
).create_agent(
    instructions="You are a polite customer service agent for Zava retail.",
    name="ZavaQAAgent"
)

# Run the agent
result = await agent.run("Do you have winter jackets?")
print(result.text)
```

**Related Resources:**
- [Microsoft Agent Framework Overview](https://learn.microsoft.com/microsoft-365/agents-sdk/agents-sdk-overview)
- [Create and Run an Agent with Agent Framework](https://learn.microsoft.com/agent-framework/tutorials/agents/run-agent)
- [Agent Types: Chat Client Agent](https://learn.microsoft.com/agent-framework/user-guide/agents/agent-types/chat-client-agent)


<br/>

---

## 5. Model Management and Development Lifecycle

### 5.1 The AI Development Lifecycle

Building production AI applications involves a structured lifecycle:

1. **Model Selection:** Choose the right model for your use case
2. **Customization:** Fine-tune or distill models for specific tasks
3. **Deployment:** Deploy models with appropriate configurations
4. **Monitoring:** Track performance and costs in production
5. **Iteration:** Continuously improve based on feedback

### 5.2 Model Selection

Azure AI Foundry provides access to a wide range of models through the **Model Catalog**:

- **Azure OpenAI Models:** GPT-4o, GPT-4o-mini, GPT-3.5-turbo
- **Open Source Models:** Llama, Phi, Mistral
- **Specialized Models:** Vision, speech, embedding models

**Selection Criteria:**
- **Capability:** Does the model support your task?
- **Performance:** Speed vs. accuracy tradeoffs
- **Cost:** Token pricing and throughput
- **Compliance:** Data residency and safety requirements

### 5.3 Model Customization

When base models don't meet specific requirements, you can customize them:

#### Fine-Tuning
**What:** Train the model on your specific examples to improve performance
**When to use:**
- Reduce prompt engineering overhead
- Modify style and tone consistently
- Generate outputs in specific formats
- Optimize for efficiency (distillation)

#### Distillation
**What:** Use a larger model's outputs to train a smaller, more efficient model
**Benefits:**
- Lower latency and cost
- Similar task performance with smaller models
- Efficient use of production data

### 5.4 Deployment Types

Azure AI Foundry offers different deployment options:

| Deployment Type | Best For | Key Features |
|----------------|----------|--------------|
| **Standard** | Development, variable workloads | Pay-per-token, flexible scaling |
| **Provisioned** | Production, predictable workloads | Reserved capacity, consistent performance |
| **Global-Standard** | Geographic distribution | Multi-region availability |
| **Developer** | Fine-tuned model testing | Cost-efficient evaluation |

### 5.5 Zava's Model Strategy

#### Model Selection
- **Customer QA Agent:** GPT-4o-mini (cost-effective, polite responses)
- **Inventory Agent:** GPT-3.5-turbo (fast, structured outputs)
- **Loyalty Agent:** GPT-4o (complex reasoning for personalization)

#### Customization Approach
1. **Baseline:** Start with base models + prompt engineering
2. **Fine-Tuning:** Train GPT-4o-mini on Zava's tone guidelines for politeness
3. **Distillation:** Use GPT-4o production data to improve GPT-4o-mini performance
4. **Evaluation:** Measure politeness, accuracy, and cost improvements

#### Deployment Strategy
- **Development:** Standard deployments for experimentation
- **Production:** Provisioned deployments for predictable costs
- **Global:** Multi-region deployment for customer proximity

**Example Lifecycle:**
```
Select GPT-4o-mini → Test with prompts → Fine-tune on politeness data → 
Evaluate improvements → Deploy to production → Monitor performance → 
Collect production data → Distill to smaller model → Repeat
```

**Related Resources:**
- [Azure AI Foundry Model Catalog Overview](https://learn.microsoft.com/azure/ai-foundry/how-to/model-catalog-overview)
- [Deploy Models with Managed Compute](https://learn.microsoft.com/azure/ai-foundry/how-to/deploy-models-managed-pay-go)
- [Fine-Tuning Considerations](https://learn.microsoft.com/azure/ai-foundry/openai/concepts/fine-tuning-considerations)


<br/>

---

## 6. Observability: Evaluation, Tracing, and Monitoring

### 6.1 The Three Stages of GenAIOps

Azure AI Foundry provides comprehensive observability across three stages:

#### 1. Pre-Production Evaluation
**Purpose:** Test and validate before deployment

**Activities:**
- Run evaluations on test datasets
- Measure quality metrics (relevance, coherence, groundedness)
- Assess safety risks (harmful content, jailbreaks)
- Compare model variants

**Tools:**
- Azure AI Evaluation SDK
- Built-in evaluators (quality, safety, custom)
- AI Red Teaming Agent for adversarial testing

#### 2. Development Tracing
**Purpose:** Debug and optimize during development

**Activities:**
- Trace agent execution flows
- Inspect tool calls and outputs
- Identify bottlenecks and errors
- Validate multi-agent interactions

**Tools:**
- OpenTelemetry integration
- Azure AI Foundry tracing
- Application Insights integration

#### 3. Post-Production Monitoring
**Purpose:** Ensure quality in real-world conditions

**Activities:**
- Track performance metrics (latency, throughput)
- Monitor token consumption and costs
- Detect quality degradation
- Respond to incidents

**Tools:**
- Azure Monitor Application Insights
- Continuous evaluation for agents
- Real-time dashboards

### 6.2 Evaluation Metrics

Azure AI Foundry provides comprehensive evaluation metrics for assessing AI applications, with special support for agent-based systems.

#### Quality Metrics (AI-Assisted)

These evaluators use AI models to assess response quality on a Likert scale (1-5) or binary pass/fail:

- **Relevance:** Are responses on-topic and addressing the user's query?
- **Coherence:** Are responses logically consistent and well-structured?
- **Groundedness:** Are responses based on provided data/context (not hallucinated)?
- **Fluency:** Is the language natural, grammatically correct, and easy to read?

**Output Format:**
- `{metric_name}`: Numerical score (1-5 or 0-1)
- `{metric_name}_label`: Binary label (true/false)
- `{metric_name}_reason`: Chain-of-thought explanation
- `{metric_name}_result`: "pass" or "fail" based on threshold
- `{metric_name}_threshold`: Binarization threshold value

**Example:**
```json
{
  "relevance": 4,
  "relevance_reason": "Response directly addresses the customer's question about jacket availability",
  "relevance_result": "pass",
  "relevance_threshold": 3
}
```

#### Safety Metrics (Risk and Safety)

These evaluators detect harmful content and security vulnerabilities:

- **Content Safety Categories:**
  - **Hate & Fairness:** Discriminatory or hateful content
  - **Violence:** Violent or graphic content
  - **Sexual:** Inappropriate sexual content
  - **Self-Harm:** Content promoting self-harm

- **Security Metrics:**
  - **Protected Material:** Copyright/intellectual property violations
  - **Jailbreak Detection:** Prompt injection and manipulation attempts
  - **Indirect Attacks:** Attempts to manipulate agent behavior

**Severity Levels:** Safe, Low, Medium, High  
**Defect Rate Calculation:** `(#instances exceeding threshold / #total instances) × 100`

#### Agent-Specific Metrics

For agent-based applications, Azure AI Foundry provides enhanced continuous evaluation:

- **Conversation Success Rate:** Percentage of successful agent interactions
- **Tool Call Accuracy:** Correctness of agent tool invocations
- **Agent Handoff Quality:** Effectiveness of multi-agent coordination
- **Task Completion Rate:** Percentage of fully resolved user requests
- **Average Response Latency:** Time to complete agent interactions

#### Custom Metrics

You can create custom evaluators for domain-specific requirements:

- **Politeness Score:** For Zava's customer service tone requirements
- **Product Accuracy:** Correctness of product information provided
- **Response Time:** Customer experience latency metric
- **Brand Compliance:** Adherence to company voice and guidelines
- **Discount Accuracy:** Correct loyalty program calculations

### 6.3 Continuous Evaluation for Agents

**What is Continuous Evaluation?**  
Continuous evaluation provides near real-time observability for agent-based applications in production. Once enabled, it automatically evaluates agent interactions at a configurable sampling rate, surfacing quality and safety metrics in the Azure AI Foundry Observability dashboard.

**Key Benefits:**
1. **Early Issue Detection:** Identify problems before they impact many users
2. **Performance Optimization:** Track trends and optimize agent behavior
3. **Safety Maintenance:** Continuous monitoring for harmful content
4. **Root Cause Analysis:** Evaluations linked to traces for debugging

**How It Works:**

1. **Enable Continuous Evaluation:**
   ```python
   from azure.ai.projects.models import EvaluatorIds, AgentEvaluationRequest
   
   # Select evaluators to run continuously
   evaluators = {
       "Relevance": {"Id": EvaluatorIds.Relevance.value},
       "Fluency": {"Id": EvaluatorIds.Fluency.value},
       "Coherence": {"Id": EvaluatorIds.Coherence.value},
   }
   
   # Create continuous evaluation
   project_client.evaluation.create_agent_evaluation(
       AgentEvaluationRequest(
           thread=thread.id,
           run=run.id,
           evaluators=evaluators,
           appInsightsConnectionString=connection_string,
       )
   )
   ```

2. **Configure Sampling:**
   - **Sampling Rate:** Percentage of interactions to evaluate (e.g., 10%)
   - **Request Limit:** Maximum evaluations per hour (system limit: 1000/hour)
   - Balance between cost and coverage

3. **View Results:**
   - **Foundry Observability Dashboard:** Real-time metrics and trends
   - **Application Insights:** Detailed telemetry and custom queries
   - **Trace Integration:** Link evaluations to specific agent interactions

**Configuration Options:**

- **Reasoning Explanations:** Enable chain-of-thought reasoning for evaluation scores
- **Sampling Configuration:** Customize evaluation frequency and volume
- **Service Name:** Differentiate multiple applications in shared Application Insights

**Example Configuration:**
```python
from azure.ai.projects.models import AgentEvaluationRedactionConfiguration

# Enable reasoning explanations
project_client.evaluation.create_agent_evaluation(
    AgentEvaluationRequest(
        thread=thread.id,
        run=run.id,
        evaluators=evaluators,
        redaction_configuration=AgentEvaluationRedactionConfiguration(
            redact_score_properties=False,  # Include reasoning
        ),
        app_insights_connection_string=connection_string,
    )
)
```

### 6.4 Agent Evaluation in the Playground

The Azure AI Foundry Agents playground provides instant evaluation during development:

1. **Enable Metrics:** Select **Metrics** in the playground to evaluate conversations
2. **Choose Evaluators:** Pick from AI quality and risk/safety dimensions
3. **Chat and Evaluate:** Interact with your agent and see metrics in real-time
4. **View Thread Logs:** Inspect detailed traces with linked evaluation scores

**What You Can See:**
- Thread details and conversation flow
- Run information and execution steps
- Tool calls with arguments and results
- Inputs and outputs for each turn
- Evaluation scores with reasoning

**Note:** Playground evaluations expire after 24 hours.

### 6.5 Tracing

**What is Tracing?**  
Tracing captures the journey of a request through your application, recording events, state changes, and function calls.

**Key Concepts:**
- **Spans:** Individual operations within a trace (LLM calls, tool executions)
- **Attributes:** Metadata (function parameters, return values)
- **Semantic Conventions:** Standardized attribute names for consistency

**Multi-Agent Observability:**  
Azure AI Foundry extends OpenTelemetry with agent-specific conventions:
- Agent-to-agent interactions
- Agent state management
- Tool invocations with arguments and results
- Planning steps

### 6.6 Red Teaming

**What is Red Teaming?**  
Systematically testing your AI system by simulating adversarial attacks to uncover safety and security vulnerabilities.

**AI Red Teaming Agent:**
- Automated scans for content risks
- Evaluates attack success rates
- Generates detailed risk reports
- Logs findings for tracking

**When to Use:**
- **Design:** Model selection phase
- **Development:** Model upgrades and fine-tuning
- **Pre-Deployment:** Final safety validation

### 6.7 Zava's Observability Strategy

#### Evaluation Phase
1. **Test all three agents on sample customer queries:**
   - Customer QA Agent: 100 sample conversations
   - Inventory Agent: 50 product lookup scenarios
   - Loyalty Agent: 30 personalization cases

2. **Measure quality metrics:**
   - **Relevance:** Target ≥ 4.0/5.0 across all agents
   - **Coherence:** Target ≥ 4.5/5.0 for customer-facing responses
   - **Groundedness:** Target ≥ 4.5/5.0 for product/inventory information
   - **Fluency:** Target ≥ 4.0/5.0 for natural conversation flow

3. **Validate specialized metrics:**
   - **Politeness score:** Custom evaluator for QA agent (target ≥ 90%)
   - **Inventory accuracy:** Product info correctness (target ≥ 98%)
   - **Personalization quality:** Loyalty agent context awareness (target ≥ 85%)

4. **Run red teaming scans for safety risks:**
   - Test for jailbreak attempts
   - Validate content safety filters
   - Check for data leakage scenarios

#### Tracing in Development
1. **Trace multi-agent conversations:**
   - Capture complete conversation threads
   - Identify agent handoff points
   - Measure coordination effectiveness

2. **Inspect tool calls to external systems:**
   - Inventory database queries and latency
   - CRM system interactions for customer data
   - Loyalty points calculation accuracy

3. **Identify latency bottlenecks:**
   - Agent-to-agent communication overhead
   - External API call delays
   - Model inference times by agent

4. **Validate agent handoffs:**
   - Ensure proper context passing
   - Verify appropriate agent selection
   - Monitor handoff success rates

#### Production Monitoring with Continuous Evaluation

**Continuous Evaluation Configuration:**
```python
# Enable for all three agents with appropriate sampling
evaluators = {
    "Relevance": {"Id": EvaluatorIds.Relevance.value},
    "Coherence": {"Id": EvaluatorIds.Coherence.value},
    "Groundedness": {"Id": EvaluatorIds.Groundedness.value},
    "Hate_Unfairness": {"Id": EvaluatorIds.HateUnfairness.value},
}

# Sample 20% of production conversations
sampling_config = AgentEvaluationSamplingConfiguration(
    sampling_percent=20,
    max_requests_per_hour=500
)
```

**Real-Time Dashboards:**

1. **Track conversation success rates:**
   - Overall success rate: Target ≥ 85%
   - Resolution without escalation: Target ≥ 80%
   - Customer satisfaction scores from follow-up surveys

2. **Monitor response times by agent:**
   - Customer QA Agent: Target ≤ 2.0s
   - Inventory Agent: Target ≤ 1.5s (optimized for speed)
   - Loyalty Agent: Target ≤ 2.5s (complex calculations)
   - Multi-agent coordination: Target ≤ 4.0s total

3. **Measure token consumption and costs:**
   - Average tokens per conversation: ~450
   - Cost per conversation: Target ≤ $0.03
   - Token efficiency trends over time

4. **Detect quality degradation trends:**
   - Weekly quality metric reviews
   - Automated alerts for metrics dropping below thresholds
   - Comparison against baseline performance

5. **Enable continuous safety evaluation:**
   - Real-time content safety monitoring
   - Jailbreak attempt detection and logging
   - Automated incident response triggers

**Example Metrics Dashboard:**
```
Customer QA Agent:
- Avg Response Time: 1.2s
- Politeness Score: 94%
- Token Usage: 450 tokens/conversation
- Conversation Success: 89%

Inventory Agent:
- Product Accuracy: 98%
- Alternative Suggestions: 76% acceptance
- API Latency: 250ms

Loyalty Agent:
- Discount Accuracy: 99.5%
- Personalization Score: 87%
- Customer Satisfaction: +12%
```

**Related Resources:**
- [Observability in Generative AI](https://learn.microsoft.com/azure/ai-foundry/concepts/observability)
- [Continuously Evaluate Your AI Agents](https://learn.microsoft.com/azure/ai-foundry/how-to/continuous-evaluation-agents)
- [Trace and Observe AI Agents](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/trace-agents-sdk)


<br/>

---

## 7. Governance Strategies

### 7.1 What is AI Governance?

AI governance ensures your AI applications are secure, compliant, cost-efficient, and responsible. It encompasses policies, controls, and processes that guide AI development and operations.

### 7.2 Key Governance Pillars

#### 1. Data Governance
**Protect sensitive information and maintain data quality**

Controls:
- **Data Classification:** Identify and label sensitive data
- **Access Control:** Restrict data access based on roles
- **Data Lineage:** Track data sources and transformations
- **Privacy Protection:** PII detection and redaction

#### 2. Model Governance
**Manage model lifecycle and ensure responsible AI**

Controls:
- **Model Selection Policies:** Restrict which models teams can use
- **Content Safety:** Configure content filters for all deployments
- **Version Control:** Track model versions and changes
- **Deprecation Management:** Plan for model retirements

#### 3. Access & Identity Governance
**Control who can access what resources**

Controls:
- **Role-Based Access Control (RBAC):** Assign permissions by role
- **Microsoft Entra Integration:** Centralized identity management
- **Audit Logs:** Track all access and changes
- **Conditional Access:** Context-based access policies

#### 4. Cost Governance
**Manage spending and optimize resource usage**

Controls:
- **Quota Management:** Set token limits per deployment
- **Cost Tracking:** Monitor spending by project/team
- **Budget Alerts:** Notify when thresholds are exceeded
- **Resource Optimization:** Right-size deployments

#### 5. Compliance & Reporting
**Meet regulatory requirements and demonstrate compliance**

Controls:
- **AI Reports:** Document project details, model cards, configurations
- **Evaluation Tracking:** Record quality and safety assessments
- **Incident Response:** Process for handling issues
- **Documentation:** Maintain audit trails

### 7.3 Safety & Responsible AI

#### Content Filtering
Azure AI includes default safety configurations:
- **Categories:** Hate, violence, sexual content, self-harm
- **Severity Levels:** Low, medium, high
- **Configurability:** Adjust filters for prompts and completions
- **Custom Policies:** Tailor to specific use cases

#### Mitigation Strategies
1. **System Messages:** Guide model behavior
2. **Retrieval Augmented Generation (RAG):** Ground responses in verified data
3. **Content Safety APIs:** Real-time content moderation
4. **Human-in-the-Loop:** Review high-risk decisions

### 7.4 Zava's Governance Guidance

While governance implementation is beyond the scope of this workshop, it's important to understand how Zava would approach governance for their customer support chatbot in a production environment. These guidelines provide a framework for thinking about AI governance in enterprise scenarios.

#### Data Governance Guidelines

**Customer Data Protection:**
- Classify customer PII as highly sensitive
- Implement encryption at rest and in transit
- Apply strict access controls based on least privilege principle

**Conversation Management:**
- Redact PII from conversation logs before storage
- Define retention policies (e.g., 90 days for support conversations)
- Separate public product data from sensitive customer data

**Training Data Sourcing:**
- Use only approved customer interactions with proper consent
- Maintain data lineage for model training datasets
- Implement version control for all training data

#### Model Governance Guidelines

**Model Selection and Approval:**
- Establish an approved model catalog (e.g., GPT-4o, GPT-4o-mini, GPT-3.5-turbo)
- Define criteria for model selection: performance, cost, safety, compliance
- Require testing and evaluation before production deployment

**Content Safety Configuration:**
- Set appropriate severity thresholds (e.g., Medium for customer-facing agents)
- Create custom blocklists for brand-specific concerns
- Implement regular safety audits and reviews

**Model Lifecycle Management:**
- Plan quarterly reviews for model updates
- Establish migration windows for deprecated models (e.g., 60 days)
- Track model versions and performance metrics over time

#### Access Control Guidelines

**Role-Based Permissions:**
- **Developers:** Development environment access, testing capabilities
- **Data Scientists:** Model training, evaluation, and experimentation access
- **Operators:** Production deployment and monitoring permissions
- **Auditors:** Read-only access to logs, metrics, and compliance reports

**Identity Management:**
- Leverage Microsoft Entra ID for centralized authentication
- Implement conditional access policies based on context
- Maintain audit logs for all access and changes

#### Cost Management Guidelines

**Budget Planning:**
- Allocate budgets by environment (e.g., $500/month per development team)
- Use provisioned throughput for predictable production costs
- Set alerts at threshold levels (e.g., 80% of budget)

**Cost Optimization:**
- Monitor token consumption per agent and conversation
- Review model efficiency monthly
- Optimize prompt engineering to reduce token usage
- Consider distillation for cost-effective deployment

#### Compliance and Reporting Guidelines

**Documentation Requirements:**
- Maintain project documentation in Azure AI Foundry
- Create model cards documenting capabilities and limitations
- Record evaluation results and safety assessments
- Document deployment configurations and content filter settings

**Monitoring and Auditing:**
- Generate monthly reports on model performance, safety metrics, and costs
- Schedule quarterly security and compliance reviews
- Define incident response procedures (e.g., 24-hour response for safety issues)
- Centralize documentation for audit readiness

**Example Governance Policy Framework:**
```yaml
Zava Customer Support AI Governance Framework:

Data Classification:
  - Customer PII: Highly Sensitive (encryption required)
  - Conversation History: Sensitive (90-day retention, PII redacted)
  - Product Information: Public (searchable, no restrictions)

Content Safety Standards:
  - Severity Threshold: Medium for all customer-facing agents
  - Custom Blocklist: Competitor names, internal codes, profanity
  - Safety Review: Weekly automated reports, monthly manual review

Model Approval Process:
  - Approved Models: GPT-4o, GPT-4o-mini, GPT-3.5-turbo
  - Update Cadence: Quarterly evaluation and approval cycle
  - Testing Requirements: 100+ evaluation queries before production
  - Performance Thresholds: Relevance ≥4.0, Safety defect rate <5%

Cost Controls:
  - Development Budget: $500/month per team
  - Production Deployment: Provisioned capacity for cost predictability
  - Alert Thresholds: 80% budget utilization, 90% critical
  - Optimization Reviews: Monthly efficiency assessments
```

**Key Takeaway:**  
While this workshop focuses on building, evaluating, and deploying agents, real-world production deployments require comprehensive governance frameworks. The guidelines above represent best practices that organizations like Zava should consider when moving from prototype to production.

**Related Resources:**
- [Govern Azure Platform Services for AI](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/ai/platform/governance)
- [Content Filter Configurability](https://learn.microsoft.com/azure/ai-foundry/openai/concepts/content-filter-configurability)
- [Responsible AI in Azure Workloads](https://learn.microsoft.com/azure/well-architected/ai/responsible-ai)


<br/>

---

## Summary

This workshop teaches you how to build, evaluate, and deploy production-ready agentic AI applications through Zava's customer support chatbot scenario. You'll gain hands-on experience with:

1. **Multi-Agent Architecture:** Design specialized agents that work together
2. **Azure AI Agent Service:** Deploy enterprise-grade agents at scale
3. **Microsoft Agent Framework:** Build flexible, customizable agents
4. **Model Management:** Select, customize, and deploy the right models
5. **Observability:** Evaluate, trace, and monitor AI applications
6. **Governance Awareness:** Understand governance considerations for production deployments

By the end of this workshop, you'll understand how to observe, manage, and scale agentic AI applications using Azure AI Foundry in real-world enterprise scenarios.

---

## Next Steps

Ready to get started? Head to the [Core Labs](index.md) to begin building Zava's customer support solution!

1. **Setup:** Configure your Azure AI Foundry environment
2. **Explore Agent:** Interact with the base agent
3. **Customize Model:** Fine-tune for politeness and efficiency
4. **Explore Evaluators:** Measure quality and safety
5. **Observe Performance:** Trace and monitor in production
6. **Deploy Variant:** Release optimized model to production
7. **Wrap Up:** Review and plan your next AI project

---

*Last Updated: November 2, 2025*  
*Workshop: PREL13 - Learn how to observe, manage, and scale agentic AI apps using Azure*
