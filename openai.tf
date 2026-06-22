# OpenAI East US
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Defines the East US Azure OpenAI module.

# OpenAI Module (in OAI RG)
module "openai" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//OpenAI?ref=v0.0.21"

  ritjira                    = var.ritjira
  project                    = var.project
  location                   = var.location
  oai_resource_group_name    = var.oai_resource_group_name
  oai_virtual_network_subnet = data.azurerm_subnet.subnet.id
}