output "vm_public_ip" {
  value = module.vm.public_ip_address
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "mysql_server_fqdn" {
  value = module.database.mysql_server_fqdn
}

output "monitoring_vm_public_ip" {
  value = module.monitoring.monitoring_vm_public_ip
}

output "monitoring_vm_private_ip" {
  value = module.monitoring.monitoring_vm_private_ip
}