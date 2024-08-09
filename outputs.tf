output "resource_group_name" {
  value = module.network.resource_group_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "services_subnet_id" {
  value = module.network.services_subnet_id
}

output "mysql_subnet_id" {
  value = module.network.mysql_subnet_id
}

output "services_subnet_address_prefix" {
  value = module.network.services_subnet_address_prefix
}

output "mysql_subnet_address_prefix" {
  value = module.network.mysql_subnet_address_prefix
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

output "nsg_services_id" {
  value = module.security.nsg_services_id
}