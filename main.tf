provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg-${var.environment}"
  location = var.location
}

module "network" {
  source                   = "./modules/01_network"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  project_name             = var.project_name
  environment              = var.environment
  vnet_address_space       = var.vnet_address_space
  subnet_address_prefixes  = var.subnet_address_prefixes
  db_subnet_address_prefix = var.db_subnet_address_prefix
  route_table_name         = var.route_table_name
  routes                   = var.routes
  create_public_ips        = var.create_public_ips

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql" {
  name                  = "mysql-dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = module.network.vnet_id
  registration_enabled  = true
}

module "security" {
  source              = "./modules/02_security"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  project_name        = var.project_name
  environment         = var.environment
  subnet_id           = module.network.subnet_id

  depends_on = [module.network]
}

module "vm" {
  source              = "./modules/03_vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_id
  project_name        = var.project_name
  environment         = var.environment
  admin_username      = var.vm_config.admin_username
  vm_size             = var.vm_config.size
  public_ip_id        = module.network.public_ip_ids["vm"]
  admin_ssh_key       = var.admin_ssh_key

  depends_on = [module.network, module.security]
}

module "database" {
  source               = "./modules/04_database"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  project_name         = var.project_name
  environment          = var.environment
  mysql_admin_username = var.mysql_config.admin_username
  mysql_admin_password = var.mysql_config.admin_password
  mysql_sku_name       = var.mysql_config.sku_name
  mysql_version        = var.mysql_config.version
  db_subnet_id         = module.network.db_subnet_id
  private_dns_zone_id  = azurerm_private_dns_zone.mysql.id
  private_dns_zone_link = azurerm_private_dns_zone_virtual_network_link.mysql.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.mysql]
}


module "storage" {
  source              = "./modules/05_storage"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  project_name        = var.project_name
  environment         = var.environment
  storage_config      = var.storage_config

  depends_on = [azurerm_resource_group.rg]
}

module "monitoring" {
  source              = "./modules/06_monitoring"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_id
  project_name        = var.project_name
  environment         = var.environment
  admin_username      = var.vm_config.admin_username
  admin_ssh_key       = var.admin_ssh_key
  public_ip_id        = module.network.public_ip_ids["monitoring"]

  depends_on = [module.network, module.security]
}