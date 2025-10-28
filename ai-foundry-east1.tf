# AI Foundry Module (in East US - AIF RG) - KEEP ORIGINAL NAME
module "ai_foundry" {  
  source = "git@github.com:JH-RIT/RIT-Azure.git//AIFoundry?ref=v0.0.21"

  ritjira                    = var.ritjira
  project                    = var.project
  location                   = var.location
  aif_resource_group_name    = var.aif_resource_group_name
  aif_virtual_network_subnet = data.azurerm_subnet.subnet.id
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  
  tags = var.tags
}