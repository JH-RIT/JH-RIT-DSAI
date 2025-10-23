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