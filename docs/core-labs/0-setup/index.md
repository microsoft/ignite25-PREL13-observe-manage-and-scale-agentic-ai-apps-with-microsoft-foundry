# Workshop Overview

## 1. Select Your Path

_The workshop guide is setup for use both in-venue (for instructor-led sessions) and at home (for self-guided learners). Pick the tab that reflects your learner context. It gets enforced site-wide, ensuring instructions are tailored to suit your context._

=== "INSTRUCTOR LED SESSION"

    Pick this tab if you are in an instructor led session at Microsoft Ignite.

    - **Duration** - Your session is 4 hours.
    - **Subscription** - You will use the subscription provided by Skillable
    - **Infrastructure** - Has been pre-provisioned for you!

    **✅ You're all set! [Move directly to the next step to validate it!](./00-setup.md)**

=== "SELF-GUIDED SESSION"

    Pick this tab if you are working through this on your own.

    - **Duration** - Complete the lab at your own pace
    - **Subscription** - You will need your own Azure subscription
    - **Infrastructure** - You will provision resources using scripts we provide




## 2. Workshop Objectives
This hands-on workshop teaches you how to observe, manage, and scale agentic AI applications for the Zava retail scenario using Azure AI Foundry. You will progress through three phases (_Plan → Develop → Operate_), applying tooling for agents, models, evaluation, tracing, and deployment.

!!! quote ""

    By the end of the workshop you should be able to:

    - Validate infrastructure & plan multi-agent architecture (Agent Architecture)
    - Select models & generate/support datasets (Model Context)
    - Customize models via fine-tuning or distillation (Model Customization)
    - Evaluate quality, safety & agent performance (Evaluation Metrics)
    - Trace agent + tool execution with observability tooling (Tracing Telemetry)
    - Deploy and monitor with cost & performance insights (Deployment Insights)
    
    These objectives map to the lab folders you will explore next.



## 3. Prerequisites

!!! quote ""
    Note: We provide a laptop with an Azure subscription pre-provisioned for you, for instructor-led sessions.

To complete the lab, you will need:

- A laptop with a modern browser installed - we recommend Microsoft Edge
- An Azure subscription - [sign up here for free](https://aka.ms/free)
- A personal GitHub account - [sign up here for free](https://github.com/signup)
- Familiarity with VS Code, Git and GitHub tooling
- Familiarity with Generative AI concepts & workflows


## 4. Azure Infrastructure

!!! quote ""
    This lab uses a customized version of the [Getting Started With AI Agents](https://github.com/Azure-Samples/get-started-with-ai-agents) template for Azure AI Foundry. 

    - It is pre-provisioned for instructor-led sessions. Participants are all set.
    - We provide scripts for self-guided learners to do this manually. It takes ~15-20 mins.
    
This sets up a basic Azure AI Foundry project with a model deployment and sample AI agent as shown in the architecture diagram below. The template has built-in support for tracing, monitoring, evaluations and red-teaming features - making it a good sandbox for this lab.

 ![Architecture](../../assets/architecture.png)


If provisioning it yourself, review region availability constraints when selecting location. **Our recommendation:** Use Sweden Central, or East US 2


---

!!! success "NOW READY TO PROCEED TO [LAB 0: ENVIRONMENT SETUP](00-setup.md)!"

