# Subscription and Resource Group
variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
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

# Network configuration
variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "network_resource_group_name" {
  type        = string
  description = "Resource group containing the VNet"
}

# AD Group
variable "user_AD_group_name" {
  type        = string
  description = "Azure AD group name for permissions"
}

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

# Additional Storage Account variables
variable "additional_storage_hns" {
  type        = bool
  default     = false
  description = "Enable hierarchical namespace for additional storage account"
}

variable "additional_storage_access_tier" {
  type        = string
  default     = "Hot"
  description = "Access tier for additional storage account"
}