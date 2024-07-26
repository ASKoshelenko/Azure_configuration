output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "route_table_id" {
  value = azurerm_route_table.rt.id
}

output "public_ip_addresses" {
  value = { for k, v in azurerm_public_ip.public_ips : k => v.ip_address }
}

output "public_ip_ids" {
  value = { for k, v in azurerm_public_ip.public_ips : k => v.id }
}

output "subnet_address_prefix" {
  value = "Subnet address prefix: ${azurerm_subnet.subnet.address_prefixes[0]}"
}

output "db_subnet_address_prefix" {
  value = "DB Subnet address prefix: ${azurerm_subnet.db_subnet.address_prefixes[0]}"
}