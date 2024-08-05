output "vm_public_ip" {
  value = module.network.public_ip_addresses["vm"]
}

output "monitoring_vm_public_ip" {
  value = module.network.public_ip_addresses["monitoring"]
}

output "subnet_address_prefix" {
  value = module.network.subnet_address_prefix
}

output "db_subnet_address_prefix" {
  value = module.network.db_subnet_address_prefix
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

output "app_service_name" {
  value = module.app_service.app_service_name
}

output "app_service_default_hostname" {
  value = module.app_service.app_service_default_hostname
}