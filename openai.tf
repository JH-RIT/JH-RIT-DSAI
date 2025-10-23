# OpenAI Module (in OAI RG)
module "openai" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//OpenAI?ref=v0.0.21"
  
  ritjira                      = var.ritjira
  project                      = var.project
  location                     = var.location
  oai_resource_group_name      = var.oai_resource_group_name
  oai_virtual_network_subnet   = data.azurerm_subnet.subnet.id
}