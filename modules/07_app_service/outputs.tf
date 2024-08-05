output "app_service_name" {
  value = azurerm_app_service.app.name
}

output "app_service_default_hostname" {
  value = azurerm_app_service.app.default_site_hostname
}

output "app_service_id" {
  value = azurerm_app_service.app.id
}