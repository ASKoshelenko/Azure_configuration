output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "main_subnet_id" {
  value = module.network.main_subnet_id
}

output "monitoring_subnet_id" {
  value = module.network.monitoring_subnet_id
}

output "db_subnet_id" {
  value = module.network.db_subnet_id
}

output "main_subnet_address_prefix" {
  value = module.network.main_subnet_address_prefix
}

output "monitoring_subnet_address_prefix" {
  value = module.network.monitoring_subnet_address_prefix
}

output "db_subnet_address_prefix" {
  value = module.network.db_subnet_address_prefix
}

output "vm_public_ip" {
  value = module.network.public_ip_addresses["vm"]
}

output "monitoring_vm_public_ip" {
  value = module.network.public_ip_addresses["monitoring"]
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "mysql_server_fqdn" {
  value = module.database.mysql_server_fqdn
}

output "vm_private_ip" {
  value = module.vm.vm_private_ip
}

output "monitoring_vm_private_ip" {
  value = module.monitoring.monitoring_vm_private_ip
}

output "nsg_main_id" {
  value = module.security.nsg_main_id
}

output "nsg_monitoring_id" {
  value = module.security.nsg_monitoring_id
}