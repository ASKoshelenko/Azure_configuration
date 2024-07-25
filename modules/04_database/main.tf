resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = "db-mysql-${var.project_name}-${var.environment}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.mysql_admin_username
  administrator_password = var.mysql_admin_password
  backup_retention_days  = 7
  delegated_subnet_id    = var.db_subnet_id
  private_dns_zone_id    = var.private_dns_zone_id
  sku_name               = var.mysql_sku_name
  version                = var.mysql_version

  depends_on = [var.private_dns_zone_link]
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = "db-mysqldb-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}