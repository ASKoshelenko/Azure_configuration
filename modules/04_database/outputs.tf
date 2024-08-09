output "mysql_server_fqdn" {
  value = azurerm_mysql_flexible_server.marathon_mysql.fqdn
}

output "mysql_server_name" {
  value = azurerm_mysql_flexible_server.marathon_mysql.name
}

output "mysql_database_name" {
  value = azurerm_mysql_flexible_database.marathon_mysql.name
}