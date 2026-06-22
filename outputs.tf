# Outputs
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Exposes deployed resource identifiers.

# OpenAI Outputs
output "openai_endpoint" {
  description = "OpenAI service endpoint"
  value       = module.openai.openai.endpoint
  sensitive   = true
}

output "openai_name" {
  description = "OpenAI service name"
  value       = module.openai.openai.name
}

output "openai_resource_id" {
  description = "OpenAI resource ID"
  value       = module.openai.openai.id
}

# AI Foundry East US Outputs (keep existing names - use module.ai_foundry)
output "ai_foundry_id" {
  description = "AI Foundry Hub ID"
  value       = module.ai_foundry.resource_id
}

output "ai_foundry_discovery_url" {
  description = "AI Foundry Hub discovery URL"
  value       = module.ai_foundry.discovery_url
}

output "ai_foundry_workspace_id" {
  description = "AI Foundry Hub workspace ID"
  value       = module.ai_foundry.workspace_id
}

output "ai_foundry_storage_id" {
  description = "AI Foundry Storage Account ID"
  value       = module.ai_foundry.storage_account_id
}

output "ai_foundry_key_vault_id" {
  description = "AI Foundry Key Vault ID"
  value       = module.ai_foundry.key_vault_id
}

output "ai_foundry_app_insights_id" {
  description = "AI Foundry Application Insights ID"
  value       = module.ai_foundry.application_insights_id
}

# AI Foundry East US 2 Outputs (new)
output "ai_foundry_east2_id" {
  description = "AI Foundry East2 Hub ID"
  value       = module.ai_foundry_east2.resource_id
}

output "ai_foundry_east2_discovery_url" {
  description = "AI Foundry East2 Hub discovery URL"
  value       = module.ai_foundry_east2.discovery_url
}

output "ai_foundry_east2_workspace_id" {
  description = "AI Foundry East2 Hub workspace ID"
  value       = module.ai_foundry_east2.workspace_id
}

output "ai_foundry_east2_storage_id" {
  description = "AI Foundry East2 Storage Account ID"
  value       = module.ai_foundry_east2.storage_account_id
}

output "ai_foundry_east2_key_vault_id" {
  description = "AI Foundry East2 Key Vault ID"
  value       = module.ai_foundry_east2.key_vault_id
}

output "ai_foundry_east2_app_insights_id" {
  description = "AI Foundry East2 Application Insights ID"
  value       = module.ai_foundry_east2.application_insights_id
}

# AML Workspace Outputs
output "aml_workspace_id" {
  description = "Azure ML Workspace ID"
  value       = module.azureml_workspace.ml_workspace_id
}

output "aml_workspace_name" {
  description = "Azure ML Workspace name"
  value       = module.azureml_workspace.ml_workspace_name
}

# Storage Account Outputs
output "storage_account_id" {
  description = "Storage Account ID"
  value       = module.azure_storage.storage_account_id
}

# Key Vault Outputs
output "key_vault_id" {
  description = "Key Vault ID"
  value       = module.azure_kv.key_vault_id
}

# Application Insights Outputs
output "application_insights_id" {
  description = "Application Insights ID"
  value       = module.app_insight_workspace.application_insights_id
}

# Add these OpenAI East US 2 outputs
output "openai_east2_endpoint" {
  description = "OpenAI East2 service endpoint"
  value       = module.openai_east2.openai.endpoint
  sensitive   = true
}

output "openai_east2_name" {
  description = "OpenAI East2 service name"
  value       = module.openai_east2.openai.name
}

output "openai_east2_resource_id" {
  description = "OpenAI East2 resource ID"
  value       = module.openai_east2.openai.id
}

# Slot Blob Data Store Outputs
output "sqlstage_storage_account_name" {
  description = "Storage account name for SQL staging slot test data"
  value       = local.sqlstage_storage_account_name
}

output "sqlstage_storage_account_id" {
  description = "Resource ID for the SQL staging slot blob storage account"
  value       = azurerm_storage_account.sqlstage.id
}

output "sqlprod_storage_account_name" {
  description = "Storage account name for SQL production slot data"
  value       = local.sqlprod_storage_account_name
}

output "sqlprod_storage_account_id" {
  description = "Resource ID for the SQL production slot blob storage account"
  value       = azurerm_storage_account.sqlprod.id
}

output "blob_store_retention_days" {
  description = "Lifecycle retention period applied to SQL staging and production storage accounts"
  value       = var.blob_retention_days
}