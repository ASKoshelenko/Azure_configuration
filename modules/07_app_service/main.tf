resource "azurerm_app_service_plan" "app_plan" {
  name                = "asp-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "marathon_dotnet_app" {
  name                = "app-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id

  site_config {
    linux_fx_version = "DOTNETCORE|6.0"
    always_on        = true
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_RUN_FROM_PACKAGE"            = "1"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_vnet_integration" {
  count          = var.enable_vnet_integration ? 1 : 0
  app_service_id = azurerm_app_service.marathon_dotnet_app.id
  subnet_id      = var.subnet_id
}