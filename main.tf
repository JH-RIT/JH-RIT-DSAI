# Main Data Sources
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Resolves shared Azure resource references.

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

data "azurerm_client_config" "current" {}