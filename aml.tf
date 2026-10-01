# Azure Machine Learning
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Defines AML workspace dependencies and workspace module.

# App Insights Module (in AML RG)
module "app_insight_workspace" {
  source = "git::https://github.com/JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/app-insight?ref=v2.0.1"

  jira_ticket                        = var.jira_ticket
  application_name                   = var.application_name
  environment                        = var.environment
  location                           = var.location
  resource_group_name                = var.aml_resource_group_name
  create_new_application_insights    = var.create_new_application_insights
  existing_application_insights_name = var.existing_application_insights_name
  tags                               = data.azurerm_resource_group.aml.tags
}

# Azure Storage Module (in AML RG) - AML's built-in storage
module "azure_storage" {
  source = "git::https://github.com/JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azure-storage?ref=v2.0.1"

  jira_ticket                   = var.jira_ticket
  application_name              = var.application_name
  environment                   = var.environment
  location                      = var.location
  resource_group_name           = var.aml_resource_group_name
  vnet_subnet_id                = data.azurerm_subnet.subnet.id
  create_new_storage_account    = var.create_new_storage_account
  existing_storage_account_name = var.existing_storage_account_name
  create_private_endpoint       = var.create_private_endpoint
  tags                          = data.azurerm_resource_group.aml.tags
  private_dns_zone_ids = {
    blob  = ["${local.central_private_dns_zone_base_id}/privatelink.blob.core.windows.net"]
    file  = ["${local.central_private_dns_zone_base_id}/privatelink.file.core.windows.net"]
    dfs   = ["${local.central_private_dns_zone_base_id}/privatelink.dfs.core.windows.net"]
    table = ["${local.central_private_dns_zone_base_id}/privatelink.table.core.windows.net"]
    queue = ["${local.central_private_dns_zone_base_id}/privatelink.queue.core.windows.net"]
  }
}

# Azure Key Vault Module (in AML RG)
module "azure_kv" {
  source = "git::https://github.com/JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azure-kv?ref=v2.0.1"

  jira_ticket             = var.jira_ticket
  application_name        = var.application_name
  environment             = var.environment
  location                = var.location
  resource_group_name     = var.aml_resource_group_name
  vnet_subnet_id          = data.azurerm_subnet.subnet.id
  create_new_key_vault    = var.create_new_key_vault
  existing_key_vault_name = var.existing_key_vault_name
  create_private_endpoint = var.create_private_endpoint
  tags                    = data.azurerm_resource_group.aml.tags
  private_dns_zone_id     = "${local.central_private_dns_zone_base_id}/privatelink.vaultcore.azure.net"
}

# Azure ML Workspace Module (in AML RG)
module "azureml_workspace" {
  source = "git::https://github.com/JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azureml-workspace?ref=v2.0.1"

  jira_ticket             = var.jira_ticket
  application_name        = "dsai-aml" # Hardcoded to match existing workspace
  environment             = var.environment
  location                = var.location
  resource_group_name     = var.aml_resource_group_name
  vnet_subnet_id          = data.azurerm_subnet.subnet.id
  create_new_workspace    = var.create_new_workspace
  create_private_endpoint = var.create_private_endpoint
  tags                    = data.azurerm_resource_group.aml.tags

  # Add the existing container registry ID
  container_registry_id = "/subscriptions/9c5d40b3-75aa-4bdf-b1aa-3f22cd0661c8/resourceGroups/JH-RIT-DSAI-AML-RG/providers/Microsoft.ContainerRegistry/registries/09fba36dd1cd423db79f4ef315c5d833"

  application_insights_id = module.app_insight_workspace.application_insights_id
  key_vault_id            = module.azure_kv.key_vault_id
  storage_account_id      = module.azure_storage.storage_account_id
  private_dns_zone_ids = [
    "${local.central_private_dns_zone_base_id}/privatelink.api.azureml.ms",
    "${local.central_private_dns_zone_base_id}/privatelink.notebooks.azure.net"
  ]

  depends_on = [
    module.app_insight_workspace,
    module.azure_storage,
    module.azure_kv
  ]
}

resource "azapi_resource" "workspaceblobstore" {
  type      = "Microsoft.MachineLearningServices/workspaces/datastores@2026-05-15-preview"
  name      = "workspaceblobstore"
  parent_id = module.azureml_workspace.ml_workspace_id

  schema_validation_enabled = false

  body = {
    properties = {
      datastoreType = "AzureBlob"
      accountName   = "rit2820dsaiamlprodsa"
      containerName = "azureml-blobstore-09fba36d-d1cd-423d-b79f-4ef315c5d833"
      isDefault     = true

      credentials = {
        credentialsType = "None"
      }

      serviceDataAccessAuthIdentity = "WorkspaceSystemAssignedIdentity"
    }
  }

  depends_on = [module.azureml_workspace]
}