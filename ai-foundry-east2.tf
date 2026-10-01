# AI Foundry East US 2
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Defines the East US 2 Azure AI Foundry module.

# AI Foundry Module (in East US 2)
module "ai_foundry_east2" {
  source = "git::https://github.com/JH-RIT/RIT-Azure.git//AIFoundry?ref=v2.0.1"

  ritjira                    = var.ritjira
  project                    = "${var.project}e2" # Add "e2" for East US 2
  location                   = "eastus2"
  aif_resource_group_name    = "JH-RIT-DSAI-AIF-EAST2-RG"
  aif_virtual_network_subnet = "/subscriptions/9c5d40b3-75aa-4bdf-b1aa-3f22cd0661c8/resourceGroups/INFRASTRUCTURE-SVI-USE-ONLY-RG/providers/Microsoft.Network/virtualNetworks/AZ-EAST2-JH-RIT-DSAI-JHU-Academic-DC-10.209.89.0-24/subnets/10.209.89.0-25"
  tenant_id                  = data.azurerm_client_config.current.tenant_id

  tags                          = data.azurerm_resource_group.ai_foundry_east2.tags
  foundry_system_tags           = local.ai_foundry_system_tags
  private_dns_zone_ids_blob     = ["${local.central_private_dns_zone_base_id}/privatelink.blob.core.windows.net"]
  private_dns_zone_ids_dfs      = ["${local.central_private_dns_zone_base_id}/privatelink.dfs.core.windows.net"]
  key_vault_private_dns_zone_id = "${local.central_private_dns_zone_base_id}/privatelink.vaultcore.azure.net"
  foundry_private_dns_zone_id   = "${local.central_private_dns_zone_base_id}/privatelink.api.azureml.ms"
  enable_blob_cors_rules        = true
  blob_cors_rules               = local.azure_portal_blob_cors_rules
  enable_share_cors_rules       = true
  share_cors_rules              = local.azure_portal_share_cors_rules
}