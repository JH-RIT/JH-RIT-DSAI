# Second Storage Account Module (in main RG) - Using StorageAccount module
module "additional_storage" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//StorageAccount?ref=v0.0.21"
  
  ritjira                    = var.ritjira
  project                    = var.project
  location                   = var.location
  st_resource_group_name     = var.resource_group_name
  st_virtual_network_subnet  = data.azurerm_subnet.subnet.id
  hns                        = var.additional_storage_hns
  access_tier               = var.additional_storage_access_tier
  tags                      = var.tags
}