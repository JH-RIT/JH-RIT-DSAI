# AI Foundry Module (in East US 2)
module "ai_foundry_east2" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//AIFoundry?ref=v0.0.21"

  ritjira                    = var.ritjira
  project                    = "${var.project}e2"  # Add "e2" for East US 2
  location                   = "eastus2"
  aif_resource_group_name    = "JH-RIT-DSAI-AIF-EAST2-RG"
  aif_virtual_network_subnet = "/subscriptions/9c5d40b3-75aa-4bdf-b1aa-3f22cd0661c8/resourceGroups/INFRASTRUCTURE-SVI-USE-ONLY-RG/providers/Microsoft.Network/virtualNetworks/AZ-EAST2-JH-RIT-DSAI-JHU-Academic-DC-10.209.89.0-24/subnets/10.209.89.0-25"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  
  tags = var.tags
}