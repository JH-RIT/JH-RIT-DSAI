# Variables
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Declares configurable infrastructure inputs.

# Subscription and Resource Group
variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "app_resource_group_name" {
  type        = string
  description = "Resource group name for application resources, including SQL production and staging storage accounts."
}

variable "location" {
  type        = string
  description = "Azure region"
}

# OpenAI specific variables
variable "ritjira" {
  type        = string
  description = "RIT JIRA ticket number"
}

variable "project" {
  type        = string
  description = "Project name"
}

# AML specific variables
variable "jira_ticket" {
  type        = string
  description = "JIRA ticket number for AML naming"
}

variable "application_name" {
  type        = string
  description = "Application name for AML"
}

variable "environment" {
  type        = string
  description = "Environment (dev/test/prod)"
}

# Resource creation flags
variable "create_new_workspace" {
  type        = bool
  default     = true
  description = "Create new AML workspace"
}

variable "create_new_application_insights" {
  type        = bool
  default     = true
  description = "Create new Application Insights"
}

variable "create_new_storage_account" {
  type        = bool
  default     = true
  description = "Create new Storage Account"
}

variable "create_new_key_vault" {
  type        = bool
  default     = true
  description = "Create new Key Vault"
}

variable "create_private_endpoint" {
  type        = bool
  default     = true
  description = "Create private endpoints"
}

# Existing resource names (optional)
variable "existing_application_insights_name" {
  type        = string
  default     = null
  description = "Name of existing Application Insights"
}

variable "existing_storage_account_name" {
  type        = string
  default     = null
  description = "Name of existing Storage Account"
}

variable "existing_key_vault_name" {
  type        = string
  default     = null
  description = "Name of existing Key Vault"
}

# Network configuration - East US
variable "vnet_name" {
  type        = string
  description = "Virtual Network name for East US"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name for East US"
}

# Network configuration - East US 2
variable "vnet_name_east2" {
  type        = string
  description = "Virtual Network name for East US 2"
}

variable "subnet_name_east2" {
  type        = string
  description = "Subnet name for East US 2"
}

variable "network_resource_group_name" {
  type        = string
  description = "Resource group containing the VNets"
}

# AD Group
# Tags
variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

# Resource Groups
variable "aml_resource_group_name" {
  type        = string
  description = "Resource group name for AML resources"
}

variable "oai_resource_group_name" {
  type        = string
  description = "Resource group name for OpenAI resources"
}

variable "oai_resource_group_name_east2" {
  type        = string
  description = "Resource group name for OpenAI resources (East US 2)"
}

variable "aif_resource_group_name" {
  type        = string
  description = "Resource group name for AI Foundry resources (East US)"
}

variable "aif_resource_group_name_east2" {
  type        = string
  description = "Resource group name for AI Foundry resources (East US 2)"
}

# Existing Storage Account variables
variable "additional_storage_hns" {
  type        = bool
  default     = false
  description = "Enable hierarchical namespace for existing storage account."
}

variable "additional_storage_access_tier" {
  type        = string
  default     = "Hot"
  description = "Access tier for existing storage account."
}

# Slot Blob Data Store Storage Account variables
variable "data_store_jira" {
  type        = string
  default     = "4525"
  description = "JIRA ticket number for SQL production and staging data store storage account naming. Do not include the RIT prefix."

  validation {
    condition     = can(regex("^[0-9]+$", var.data_store_jira))
    error_message = "The data store JIRA value must be numeric because the storage module prepends 'rit' during naming."
  }
}

variable "sqlprod_storage_project" {
  type        = string
  default     = "dsaisqlprod"
  description = "Project segment for the SQL production blob storage account name."
}

variable "sqlstage_storage_project" {
  type        = string
  default     = "dsaisqlstage"
  description = "Project segment for the SQL staging blob storage account name."
}

variable "sqlprod_storage_hns" {
  type        = bool
  default     = false
  description = "Enable hierarchical namespace for the SQL production blob storage account."
}

variable "sqlstage_storage_hns" {
  type        = bool
  default     = false
  description = "Enable hierarchical namespace for the SQL staging blob storage account."
}

variable "sqlprod_storage_access_tier" {
  type        = string
  default     = "Hot"
  description = "Access tier for the SQL production blob storage account."
}

variable "sqlstage_storage_access_tier" {
  type        = string
  default     = "Hot"
  description = "Access tier for the SQL staging blob storage account."
}

variable "blob_retention_days" {
  type        = number
  default     = 7
  description = "Number of days to retain blobs in SQL production and staging storage accounts before automatic deletion."

  validation {
    condition     = var.blob_retention_days >= 1 && var.blob_retention_days <= 365
    error_message = "Blob retention days must be between 1 and 365."
  }
}