resource "azurerm_storage_account" "storage" {
  name                     = "${var.project_name}storage${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.project_name}-container-${var.environment}"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}