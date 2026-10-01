# Main Data Sources
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Resolves shared Azure resource references.

locals {
  central_private_dns_zone_base_id = "/subscriptions/9acba645-cdeb-4c07-87d7-5197d0858c58/resourceGroups/esg-azuredns/providers/Microsoft.Network/privateDnsZones"

  azure_portal_blob_cors_rules = [{
    allowed_headers    = ["*"]
    allowed_methods    = ["GET", "HEAD", "PUT", "DELETE", "OPTIONS", "POST", "PATCH"]
    allowed_origins    = ["https://mlworkspace.azure.ai", "https://ml.azure.com", "https://*.ml.azure.com", "https://ai.azure.com", "https://*.ai.azure.com"]
    exposed_headers    = ["*"]
    max_age_in_seconds = 1800
  }]

  azure_portal_share_cors_rules = [{
    allowed_headers    = ["*"]
    allowed_methods    = ["GET", "HEAD", "PUT", "DELETE", "OPTIONS", "POST"]
    allowed_origins    = ["https://mlworkspace.azure.ai", "https://ml.azure.com", "https://*.ml.azure.com", "https://ai.azure.com", "https://*.ai.azure.com"]
    exposed_headers    = ["*"]
    max_age_in_seconds = 1800
  }]

  ai_foundry_system_tags = {
    "__SYSTEM__AzureOpenAI_rit2820-dsai2-prod-oai" = "/subscriptions/9c5d40b3-75aa-4bdf-b1aa-3f22cd0661c8/resourceGroups/JH-RIT-DSAI-OAI-EAST2-RG/providers/Microsoft.CognitiveServices/accounts/rit2820-dsai2-prod-oai"
  }
}

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

data "azurerm_virtual_network" "vnet_east2" {
  name                = var.vnet_name_east2
  resource_group_name = var.network_resource_group_name
}

data "azurerm_subnet" "subnet_east2" {
  name                 = var.subnet_name_east2
  virtual_network_name = data.azurerm_virtual_network.vnet_east2.name
  resource_group_name  = var.network_resource_group_name
}

data "azurerm_resource_group" "aml" {
  name = var.aml_resource_group_name
}

data "azurerm_resource_group" "app" {
  name = var.app_resource_group_name
}

data "azurerm_resource_group" "production" {
  name = var.resource_group_name
}

data "azurerm_resource_group" "ai_foundry" {
  name = var.aif_resource_group_name
}

data "azurerm_resource_group" "ai_foundry_east2" {
  name = var.aif_resource_group_name_east2
}

data "azurerm_resource_group" "oai" {
  name = var.oai_resource_group_name
}

data "azurerm_resource_group" "oai_east2" {
  name = var.oai_resource_group_name_east2
}

data "azurerm_client_config" "current" {}