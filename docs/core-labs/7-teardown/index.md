# Lab 7: Teardown & Cleanup

Properly clean up Azure resources to avoid unnecessary costs after completing the workshop.

## Description

Learn best practices for decommissioning development environments and cleaning up Azure resources. This lab ensures you don't incur ongoing costs for resources you're no longer using.

## Learning Objectives

By the end of this lab, you will be able to:

- ✅ Identify all Azure resources created during the workshop
- ✅ Safely delete resources without data loss
- ✅ Verify complete cleanup and cost termination
- ✅ Export important artifacts before cleanup
- ✅ Understand resource cleanup best practices

## Prerequisites

- ✅ Completed all core labs (or decided to end workshop)
- ✅ Exported any data or artifacts you want to keep
- ✅ Noted any resources you want to preserve

## Previous Lab

- **[← Lab 6: Deployment](../6-deployment/60-deployment.md)**

## Important Warnings

!!! danger "Data Loss Warning"
    Deleting resources is **irreversible**. Ensure you've backed up any important data, models, or configurations before proceeding.

!!! warning "Skillable Users"
    If you're using a pre-provisioned Skillable environment, the resources will be automatically deleted when your lab session expires. You may skip this lab.

## Cleanup Checklist

Before deleting resources, ensure you've:

- [ ] Exported fine-tuned models you want to keep
- [ ] Saved evaluation results and reports
- [ ] Downloaded any datasets or artifacts
- [ ] Documented configurations or settings
- [ ] Noted any learnings or insights

## Instructions

### For Self-Guided Users

Run the teardown script:

```bash
cd /workspaces/ignite25-PDY123-learn-how-to-observe-manage-and-scale-agentic-ai-apps-using-azure/scripts
./3-teardown.sh
```

This script will:
1. List all resources in your resource group
2. Confirm deletion with you
3. Delete the resource group and all contained resources
4. Verify cleanup completion

### Manual Cleanup (Alternative)

If you prefer manual cleanup:

1. **Navigate to Azure Portal**
   - Go to [portal.azure.com](https://portal.azure.com)
   - Find your resource group (e.g., `rg-ignite25-prel13`)

2. **Review Resources**
   - Check all resources in the group
   - Identify any you want to preserve

3. **Delete Resource Group**
   - Click "Delete resource group"
   - Type the resource group name to confirm
   - Click "Delete"

4. **Verify Deletion**
   - Wait for deletion to complete (may take several minutes)
   - Refresh to confirm resource group is gone

## Resources to Clean Up

Typical resources created during the workshop:

- Azure AI Foundry Hub
- Azure AI Foundry Project  
- Azure OpenAI Service
- Azure AI Search Service
- Storage Accounts
- Key Vault
- Application Insights
- Log Analytics Workspace

## Cost Verification

After cleanup, verify no ongoing costs:

```bash
# Check for any remaining resources
az resource list --output table

# View recent costs (may take 24-48 hours to update)
az consumption usage list --query "[?usageEnd >= '2025-11-01']" --output table
```

## Copilot Prompts

```
Show me how to list all resources in my Azure resource group
```

```
Help me safely delete an Azure resource group with all its resources
```

```
Explain how to verify that all Azure resources have been deleted
```

## What to Keep

Consider keeping for future learning:

- **Code & Notebooks:** Fork/download the GitHub repository
- **Notes & Learnings:** Document your insights
- **Evaluation Results:** Screenshots or exported data
- **Configurations:** Copy of environment variables or settings

## Related Resources

- 📘 [Azure Cost Management](https://learn.microsoft.com/azure/cost-management-billing/)
- 📘 [Delete Resource Groups](https://learn.microsoft.com/azure/azure-resource-manager/management/delete-resource-group)
- 📘 [Azure Resource Manager](https://learn.microsoft.com/azure/azure-resource-manager/management/overview)

## What's Next?

- Explore [Additional Labs](../../more-labs/index.md) for advanced topics
- Review what you learned in the [Core Labs](../index.md)
- Share your feedback on the [Workshop Homepage](../../index.md)
