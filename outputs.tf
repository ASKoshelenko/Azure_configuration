output "vm_public_ip" {
  value = module.vm.public_ip_address
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_container_name" {
  value = module.storage.storage_container_name
}

output "mysql_server_fqdn" {
  value = module.database.mysql_server_fqdn
}