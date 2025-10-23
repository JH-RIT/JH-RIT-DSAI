# App Insights Module (in AML RG)
module "app_insight_workspace" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/app-insight?ref=v0.0.21"
  
  jira_ticket                        = var.jira_ticket
  application_name                   = var.application_name
  environment                        = var.environment
  location                           = var.location
  resource_group_name                = var.aml_resource_group_name
  create_new_application_insights    = var.create_new_application_insights
  existing_application_insights_name = var.existing_application_insights_name
  tags                               = var.tags
}

# Azure Storage Module (in AML RG) - AML's built-in storage
module "azure_storage" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azure-storage?ref=v0.0.21"
  
  jira_ticket                   = var.jira_ticket
  application_name              = var.application_name
  environment                   = var.environment
  location                      = var.location
  resource_group_name           = var.aml_resource_group_name
  vnet_subnet_id                = data.azurerm_subnet.subnet.id
  create_new_storage_account    = var.create_new_storage_account
  existing_storage_account_name = var.existing_storage_account_name
  create_private_endpoint       = var.create_private_endpoint
  tags                          = var.tags
}

# Azure Key Vault Module (in AML RG)
module "azure_kv" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azure-kv?ref=v0.0.21"
  
  jira_ticket             = var.jira_ticket
  application_name        = var.application_name
  environment             = var.environment
  location                = var.location
  resource_group_name     = var.aml_resource_group_name
  vnet_subnet_id          = data.azurerm_subnet.subnet.id
  create_new_key_vault    = var.create_new_key_vault
  existing_key_vault_name = var.existing_key_vault_name
  create_private_endpoint = var.create_private_endpoint
  tags                    = var.tags
}

# Azure ML Workspace Module (in AML RG)
module "azureml_workspace" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azureml-workspace?ref=v0.0.21"
  
  jira_ticket             = var.jira_ticket
  application_name        = "dsai-aml"              # Hardcoded to match existing workspace
  environment             = var.environment
  location                = var.location
  resource_group_name     = var.aml_resource_group_name
  vnet_subnet_id          = data.azurerm_subnet.subnet.id
  create_new_workspace    = var.create_new_workspace
  create_private_endpoint = var.create_private_endpoint
  tags                    = var.tags

  # Add the existing container registry ID
  container_registry_id   = "/subscriptions/9c5d40b3-75aa-4bdf-b1aa-3f22cd0661c8/resourceGroups/JH-RIT-DSAI-AML-RG/providers/Microsoft.ContainerRegistry/registries/09fba36dd1cd423db79f4ef315c5d833"

  application_insights_id = module.app_insight_workspace.application_insights_id
  key_vault_id            = module.azure_kv.key_vault_id
  storage_account_id      = module.azure_storage.storage_account_id

  depends_on = [
    module.app_insight_workspace,
    module.azure_storage,
    module.azure_kv
  ] 
}