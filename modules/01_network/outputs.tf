output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "vnet_id" {
  value = azurerm_virtual_network.marathon_virtual_network.id
}

output "services_subnet_id" {
  value = azurerm_subnet.services_subnet.id
}

output "mysql_subnet_id" {
  value = azurerm_subnet.mysql_subnet.id
}

output "route_table_id" {
  value = azurerm_route_table.marathon_vnet_rt.id
}

output "public_ip_addresses" {
  value = { for k, v in azurerm_public_ip.public_ips : k => v.ip_address }
}

output "public_ip_ids" {
  value = { for k, v in azurerm_public_ip.public_ips : k => v.id }
}

output "services_subnet_address_prefix" {
  value = azurerm_subnet.services_subnet.address_prefixes[0]
}

output "mysql_subnet_address_prefix" {
  value = azurerm_subnet.mysql_subnet.address_prefixes[0]
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.mysql.id
}

output "private_dns_zone_vnet_link_id" {
  value = azurerm_private_dns_zone_virtual_network_link.mysql.id
}