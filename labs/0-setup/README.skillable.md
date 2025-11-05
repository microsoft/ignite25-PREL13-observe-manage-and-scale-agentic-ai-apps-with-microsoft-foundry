# Setup For SKILLABLE

Use this guide if you are exploring this workshop during Microsoft Ignite using Skillable. To do this you will need:

- A personal GitHub account - [signup here for free](https://github.com/signup)
- Some familiarity with - Git, VSCode, Python & Jupyter notebooks
- Some familiarity with - Generative AI concepts and workflows

<br/>

## 1. Launch GitHub Codespaces

1. Click the [link](), to open up Codespaces
1. This opens a new tab with a VS Code IDE - wait till that loads completely

## 3. Authenticate With Azure

1. Open a new terminal session in that VS Code window - wait till ready.
1. Run this command - and complete the workflow with Azure Credentials provided on Skillable

    ```bash title="" linenums="0"
    az login
    ```
1. _We can now use this for managed identity credentials in code later_.

<br/>

## 4. Provision AI Agents Template

1. The [Azure Developer CLI](https://aka.ms/azd) streamlines provsioning and deployment for AI Apps.
1. The [AI Apps Gallery](https://aka.ms/ai-apps) has a number of curated AI application templates for AZD.
1. In this repo, we have scripts to setup of the [Get Started With AI Agents](https://github.com/Azure-Samples/get-started-with-ai-agents) template. The template is also created

**Populate your .env variables:** 

1. Populate the `.env` file from the provisioned environment variables

    ```
    ./scripts/7-get-env-skillable.sh
    ```

    The script will automatically:
    - ✅ Extract the correct Azure AI Project name from your deployment
    - ✅ Retrieve Azure OpenAI API key programmatically
    - ✅ Retrieve Azure AI Search API key programmatically
    - ✅ Use the correct OpenAI endpoint format (`.openai.azure.com`)
    - ✅ Configure Application Insights connection string

<!-- 1. In the terminal, you will be required to paste in your Resource Group,  checking to see if I can automate this -->

    You should see output like:

    ```
    ✅ Successfully updated .env file!

    📋 Updated Variables:
      • Resource Group: rg-ignite-PREL13
      • Location: swedencentral
      • OpenAI Endpoint: https://aoai-XXXXXXX.openai.azure.com/
      • OpenAI API Key: ✓ Retrieved
      • AI Search Endpoint: https://srch-XXXXX.search.windows.net/
      • AI Search API Key: ✓ Retrieved
      • AI Project Name: proj-XXXXX
      • Container Registry: XXXX.azurecr.io
      • Service API URI: https://ca-api-XXX...
      • Application Insights: ✓ Connected

    💡 All API keys have been automatically retrieved from Azure!

    💡 All API keys have been automatically retrieved from Azure!

    ======================================
    ✓ Done!
    ======================================
    ```

**Populate your search index:** 

1. Now populate products and update the search index

    ```
    python 2-add-product-index.py 
    ```

    You should see something like this:

    ```
    ======================================================================
    Add Products to Azure AI Search Index
    ======================================================================
    Using environment variables from system/default locations
    ✓ Azure CLI authentication verified
    Running RBAC update script to ensure proper permissions...
    ..
    ..
    Uploading 49 products to index 'zava-products'...
    ✓ Successfully uploaded 49 products to the search index!

    The product catalog is now ready for semantic search.
    ======================================================================
    ```


## 5. Complete Your Labs

_Your infrastructure is now ready! You can now launch the instruction guide and start working through the labs!_.

1. Open a new terminal in VS Code.
1. Type `mkdocs serve` - wait a few seconds to see the pop-up dialog
1. Confirm you want to open this in browser.
1. _You should see an instruction guide for labs in website preview_. 

**Start with the Validate Setup lab - then keep going**:

1. First, run the `0-setup/00-validate-setup.ipynb` notebook
1. Verify that all required environment variables were set!
1. Then keep going down the list in the instruction guide.


<br/>

## 6. Teardown & Cleanup

When you are all done with labs, you want to tear down the infrastructure. You can do this by closing your lab, which will automatically teardown all your resources.