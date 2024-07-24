resource "azurerm_storage_account" "storage" {
  name                     = "${var.project_name}storage${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

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