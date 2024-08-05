output "app_service_name" {
  value = azurerm_app_service.app.name
}

output "app_service_default_hostname" {
  value = azurerm_app_service.app.default_site_hostname
}

output "app_service_identity_principal_id" {
  value = azurerm_app_service.app.identity[0].principal_id
}