output "app_service_name" {
  value = azurerm_app_service.marathon_dotnet_app.name
}

output "app_service_default_hostname" {
  value = azurerm_app_service.marathon_dotnet_app.default_site_hostname
}

output "app_service_id" {
  value = azurerm_app_service.marathon_dotnet_app.id
}

output "app_service_plan_id" {
  value = azurerm_app_service_plan.app_plan.id
}