terraform {
  required_version = ">= 1.3"

  backend "azurerm" {
    resource_group_name  = "JH-RIT-Production-PROD-RG"
    storage_account_name = "ritterraform"
    container_name       = "tfstate"
    key                  = "RIT-2820-DSAI.tfstate"
    subscription_id      = "39bfbfc9-2ec9-4776-9551-3db2a198f7bf"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}

provider "azuread" {}

# Data sources for networking
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.network_resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.network_resource_group_name
}

data "azuread_group" "ad_group" {
  display_name = var.user_AD_group_name
}

# OpenAI Module (in OAI RG)
module "openai" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//OpenAI?ref=v0.063"
  
  ritjira                      = var.ritjira
  project                      = var.project
  location                     = var.location
  oai_resource_group_name      = var.oai_resource_group_name
  oai_virtual_network_subnet   = data.azurerm_subnet.subnet.id
}

# Second Storage Account Module (in main RG) - Using StorageAccount module
module "additional_storage" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//StorageAccount?ref=v0.063"
  
  ritjira                    = var.ritjira
  project                    = var.project
  location                   = var.location
  st_resource_group_name     = var.resource_group_name
  st_virtual_network_subnet  = data.azurerm_subnet.subnet.id
  hns                        = var.additional_storage_hns
  access_tier               = var.additional_storage_access_tier
}

# App Insights Module (in AML RG)
module "app_insight_workspace" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/app-insight?ref=v0.063"
  
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
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azure-storage?ref=v0.063"
  
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
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azure-kv?ref=v0.063"
  
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
  source = "git@github.com:JH-RIT/RIT-Azure.git//AZML-FullWorkSpace/azureml-workspace?ref=v0.063"
  
  jira_ticket             = var.jira_ticket
  application_name        = "dsai-aml"
  environment             = var.environment
  location                = var.location
  resource_group_name     = var.aml_resource_group_name
  vnet_subnet_id          = data.azurerm_subnet.subnet.id
  create_new_workspace    = var.create_new_workspace
  create_private_endpoint = var.create_private_endpoint
  tags                    = var.tags

  application_insights_id = module.app_insight_workspace.application_insights_id
  key_vault_id            = module.azure_kv.key_vault_id
  storage_account_id      = module.azure_storage.storage_account_id

  depends_on = [
    module.app_insight_workspace,
    module.azure_storage,
    module.azure_kv
  ]
}
