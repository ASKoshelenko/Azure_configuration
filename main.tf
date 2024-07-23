provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg-${var.environment}"
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  project_name        = var.project_name
  environment         = var.environment
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_id
  project_name        = var.project_name
  environment         = var.environment
  admin_username      = var.admin_username
  vm_size             = var.vm_size
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  project_name        = var.project_name
  environment         = var.environment
}

module "database" {
  source                = "./modules/database"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  project_name          = var.project_name
  environment           = var.environment
  mysql_admin_username  = var.mysql_admin_username
  mysql_admin_password  = var.mysql_admin_password
  mysql_sku_name        = var.mysql_sku_name
  mysql_version         = var.mysql_version
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_id
  project_name        = var.project_name
  environment         = var.environment
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
}