# Providers
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Configures Terraform backend and providers.

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

    azapi = {
      source  = "azure/azapi"
      version = ">= 1.13"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}

provider "azapi" {
  subscription_id = var.subscription_id
}
