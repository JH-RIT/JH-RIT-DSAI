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

# AI Foundry Outputs
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

#AML Workspace Outputs
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