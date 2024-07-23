output "vm_public_ip" {
  value = module.vm.public_ip_address
}

output "mysql_server_fqdn" {
  value = module.database.mysql_server_fqdn
}