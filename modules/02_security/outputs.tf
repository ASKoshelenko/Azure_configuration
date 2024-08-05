output "nsg_main_id" {
  value = azurerm_network_security_group.nsg_main.id
}

output "nsg_monitoring_id" {
  value = azurerm_network_security_group.nsg_monitoring.id
}