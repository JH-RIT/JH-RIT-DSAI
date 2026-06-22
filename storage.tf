# Storage
# Created by ptaft1 on 2026-06-22
# Project Purpose: Deploy secure Azure AI and data infrastructure for JH-RIT-DSAI.
# File Purpose: Defines storage accounts, private endpoints, and lifecycle policies.

locals {
  sqlprod_storage_account_name  = lower("rit${var.data_store_jira}${var.sqlprod_storage_project}")
  sqlstage_storage_account_name = lower("rit${var.data_store_jira}${var.sqlstage_storage_project}")
  data_store_tags               = merge(var.tags, { JIRA = "RIT-${var.data_store_jira}" })
}

# Existing production storage account. Keep this module managed so Terraform does not destroy rit2820dsaiprodst.
module "additional_storage" {
  source = "git@github.com:JH-RIT/RIT-Azure.git//StorageAccount?ref=v0.0.21"

  ritjira                   = var.ritjira
  project                   = var.project
  location                  = var.location
  st_resource_group_name    = var.resource_group_name
  st_virtual_network_subnet = data.azurerm_subnet.subnet.id
  hns                       = var.additional_storage_hns
  access_tier               = var.additional_storage_access_tier
  tags                      = var.tags
}

# Production SQL blob store.
resource "azurerm_storage_account" "sqlprod" {
  name                              = local.sqlprod_storage_account_name
  location                          = var.location
  resource_group_name               = var.app_resource_group_name
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  account_kind                      = "StorageV2"
  access_tier                       = var.sqlprod_storage_access_tier
  is_hns_enabled                    = var.sqlprod_storage_hns
  https_traffic_only_enabled        = true
  infrastructure_encryption_enabled = true
  min_tls_version                   = "TLS1_2"
  allow_nested_items_to_be_public   = false
  public_network_access_enabled     = false
  tags                              = local.data_store_tags

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  blob_properties {
    versioning_enabled  = false
    change_feed_enabled = false

    delete_retention_policy {
      days = var.blob_retention_days
    }

    container_delete_retention_policy {
      days = var.blob_retention_days
    }
  }
}

# Staging SQL blob store.
resource "azurerm_storage_account" "sqlstage" {
  name                              = local.sqlstage_storage_account_name
  location                          = var.location
  resource_group_name               = var.app_resource_group_name
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  account_kind                      = "StorageV2"
  access_tier                       = var.sqlstage_storage_access_tier
  is_hns_enabled                    = var.sqlstage_storage_hns
  https_traffic_only_enabled        = true
  infrastructure_encryption_enabled = true
  min_tls_version                   = "TLS1_2"
  allow_nested_items_to_be_public   = false
  public_network_access_enabled     = false
  tags                              = local.data_store_tags

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  blob_properties {
    versioning_enabled  = false
    change_feed_enabled = false

    delete_retention_policy {
      days = var.blob_retention_days
    }

    container_delete_retention_policy {
      days = var.blob_retention_days
    }
  }
}

resource "azurerm_private_endpoint" "sqlprod_blob" {
  name                = "${local.sqlprod_storage_account_name}-blob-pep"
  location            = var.location
  resource_group_name = var.app_resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = local.data_store_tags

  private_service_connection {
    name                           = "pcs-${var.sqlprod_storage_project}-st-blob"
    private_connection_resource_id = azurerm_storage_account.sqlprod.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "sqlstage_blob" {
  name                = "${local.sqlstage_storage_account_name}-blob-pep"
  location            = var.location
  resource_group_name = var.app_resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = local.data_store_tags

  private_service_connection {
    name                           = "pcs-${var.sqlstage_storage_project}-st-blob"
    private_connection_resource_id = azurerm_storage_account.sqlstage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

# Data minimization lifecycle: delete production blobs after retention period.
resource "azurerm_storage_management_policy" "sqlprod_storage_lifecycle" {
  storage_account_id = azurerm_storage_account.sqlprod.id

  rule {
    name    = "delete-sqlprod-blobs-after-retention"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        delete_after_days_since_creation_greater_than = var.blob_retention_days
      }
    }
  }

  depends_on = [azurerm_storage_account.sqlprod]
}

# Data minimization lifecycle: delete staging blobs after retention period.
resource "azurerm_storage_management_policy" "sqlstage_storage_lifecycle" {
  storage_account_id = azurerm_storage_account.sqlstage.id

  rule {
    name    = "delete-sqlstage-blobs-after-retention"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        delete_after_days_since_creation_greater_than = var.blob_retention_days
      }
    }
  }

  depends_on = [azurerm_storage_account.sqlstage]
}