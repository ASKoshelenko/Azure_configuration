resource "azurerm_storage_account" "storage" {
  name                     = "st${var.project_name}${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_config.account_tier
  account_replication_type = var.storage_config.account_replication_type

  static_website {
    index_document     = null
    error_404_document = null
  }

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = false
    default_service_version  = "2020-06-12"
    last_access_time_enabled = false
  }
}

resource "azurerm_storage_container" "container" {
  name                  = var.storage_config.container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}