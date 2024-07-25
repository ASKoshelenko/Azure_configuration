output "vm_public_ip" {
  value = module.network.public_ip_addresses["vm"]
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "mysql_server_fqdn" {
  value = module.database.mysql_server_fqdn
}

output "monitoring_vm_public_ip" {
  value = module.network.public_ip_addresses["monitoring"]
}

output "monitoring_vm_private_ip" {
  value = module.monitoring.monitoring_vm_private_ip
}

output "private_dns_zone_link_id" {
  value = azurerm_private_dns_zone_virtual_network_link.mysql.id
}