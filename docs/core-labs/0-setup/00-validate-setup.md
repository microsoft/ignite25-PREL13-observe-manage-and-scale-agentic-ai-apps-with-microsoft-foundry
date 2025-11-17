# Lab 0: Environment Setup

!!! quote ""

    By the end of this section, you will:

    - [ ] Launch (or access) the workshop Codespaces environment
    - [ ] Authenticate with Azure using the Azure CLI
    - [ ] Generate a `.env` file populated with required environment variables
    - [ ] (If self-guided) Provision workshop infrastructure resources
    - [ ] Populate product catalog and (optionally) additional model deployments
    - [ ] Run the validation notebook to confirm everything is ready
    - [ ] Start the MkDocs guide locally for navigation

---

## 1. Environment & Azure Authentication

Use the tab for your learning context. Both tracks converge on validating environment variables via a notebook before starting subsequent labs.

=== "INSTRUCTOR LED SESSION"

    You are using a pre-provisioned Skillable Azure subscription and a ready Codespaces image.

    1. Open a terminal in VS Code.
    1. Authenticate with Azure:
        ```title="" linenums="0"
        az login
        ```
    1. Complete the browser/device-code flow using Skillable-provided credentials.
    5. Confirm the correct subscription is selected (defaults are fine).
    1. Retrieve and populate environment variables:
        ```title="" linenums="0"
        ./scripts/1-get-env-skillable.sh
        ```
    1. Populate product catalog (Azure AI Search index):
        ```title="" linenums="0"
        python ./scripts/2-add-product-index.py
        ```
    1. Proceed to Section 2 to validate the setup with the notebook.

    !!! success "Skillable environment authenticated & configured. Continue to validation."

=== "SELF-GUIDED SESSION"

    You will provision all Azure resources yourself, then configure local variables.

    1. Fork this repo: use the GitHub Fork button (keeps a personal sandbox).
    2. Launch a new Codespace from your fork (Code → Codespaces → New).
    3. Authenticate with Azure:
        ```title="" linenums="0"
        az login
        ```
    4. Provision infrastructure (customized AI Agents template):
        ```title="" linenums="0"
        cd scripts
        ./1-setup.sh
        ```
       Provide interactive answers (example): branch `for-release-1.0.4`, env `Ignite-PREL13`, region `swedencentral`, your subscription id, enable search = yes, accept defaults, proceed.
    5. Generate/update environment variables from existing resources:
        ```title="" linenums="0"
        ./1-update-env-selfguided.sh
        ```
    6. Populate product catalog (Azure AI Search index):
        ```title="" linenums="0"
        python 2-add-product-index.py
        ```
    7. (Optional) Add additional model deployments for evaluation scenarios:
        ```title="" linenums="0"
        ./2-add-model-choices.sh
        ```
    8. Proceed to Section 2 to validate the setup with the notebook.

    !!! success "Self-guided infrastructure provisioned & environment variables prepared. Continue to validation."

---

## 3. Validate The Environment

Use the provided notebook to ensure all required variables and service connections are available.

1. In VS Code Explorer, open the folder: `labs/0-setup/`
2. Open the notebook: `labs/0-setup/00-validate-setup.ipynb`
3. Select the default Python kernel ("Select Kernel" if prompted)
4. (Optional) Clear All Outputs
5. Run all cells (Run All)
6. Scroll to the final cell for summary

Expected results:
- Missing variables = 0
- All service checks pass (OpenAI, Search, Project, Insights)
- Model deployments accessible (including additional ones if added)


```bash
======================================================================
📊 VALIDATION SUMMARY - Agentic AI Workshop Environment
======================================================================
✅ Valid variables: 46
❌ Missing variables: 0
⚠️  Warnings: 0

🎉 All environment variables are properly configured!
    You're ready to proceed with all lab exercises.

📚 Available Labs:
    - Lab 1: Agents (labs/1-agents/)
    - Lab 2: Models (labs/2-models/)
    - Lab 3: Customization (labs/3-customization/)
    - Lab 4: Evaluation (labs/4-evaluation/)
    - Lab 5: Tracing (labs/5-tracing/)
    - Lab 6: Deployment (labs/6-deployment/)
    - Lab 7: Teardown (labs/7-teardown/)
```

---

!!! note "Next Step"
    Validation successful? Close this notebook to free resources and continue to Lab 1: Agents.
