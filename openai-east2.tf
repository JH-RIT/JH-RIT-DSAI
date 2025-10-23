# OpenAI Module (in East US 2 - OAI-EAST2 RG)
module "openai_east2" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//OpenAI?ref=v0.0.21"
  
  ritjira                      = var.ritjira
  project                      = "${var.project}2"  # dsai2
  location                     = "eastus2"
  oai_resource_group_name      = var.oai_resource_group_name_east2
  oai_virtual_network_subnet   = data.azurerm_subnet.subnet_east2.id
}