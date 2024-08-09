provider "azurerm" {
  features {}
}

module "network" {
  source                       = "./modules/01_network"
  project_name                 = var.project_name
  environment                  = var.environment
  location                     = var.location
  vnet_address_space           = var.vnet_address_space
  services_subnet_address_prefix = var.services_subnet_address_prefix
  mysql_subnet_address_prefix   = var.mysql_subnet_address_prefix
  routes                       = var.routes
  create_public_ips            = var.create_public_ips
}

module "security" {
  source               = "./modules/02_security"
  resource_group_name  = module.network.resource_group_name
  location             = var.location
  project_name         = var.project_name
  environment          = var.environment
  services_subnet_id   = module.network.services_subnet_id
  allowed_ip_ranges    = var.allowed_ip_ranges
}

module "vm" {
  source                 = "./modules/03_vm"
  resource_group_name    = module.network.resource_group_name
  location               = var.location
  subnet_id              = module.network.services_subnet_id
  project_name           = var.project_name
  environment            = var.environment
  admin_username         = var.vm_config.admin_username
  vm_size                = var.vm_config.size
  public_ip_id           = module.network.public_ip_ids["vm"]
  admin_ssh_keys         = var.admin_ssh_keys
  os_disk_config         = var.vm_os_disk_config
  source_image_reference = var.vm_source_image_reference
}

module "database" {
  source                       = "./modules/04_database"
  resource_group_name          = module.network.resource_group_name
  location                     = var.location
  project_name                 = var.project_name
  environment                  = var.environment
  mysql_admin_username         = var.mysql_config.admin_username
  mysql_admin_password         = var.mysql_config.admin_password
  mysql_sku_name               = var.mysql_config.sku_name
  mysql_version                = var.mysql_config.version
  mysql_subnet_id              = module.network.mysql_subnet_id
  private_dns_zone_id          = module.network.private_dns_zone_id
  private_dns_zone_vnet_link_id = module.network.private_dns_zone_vnet_link_id
}

module "storage" {
  source              = "./modules/05_storage"
  resource_group_name = module.network.resource_group_name
  location            = var.location
  project_name        = var.project_name
  environment         = var.environment
  storage_config      = var.storage_config

  depends_on = [module.network]
}

module "monitoring" {
  source                 = "./modules/06_monitoring"
  resource_group_name    = module.network.resource_group_name
  location               = var.location
  subnet_id              = module.network.services_subnet_id
  project_name           = var.project_name
  environment            = var.environment
  admin_username         = var.vm_config.admin_username
  admin_ssh_keys         = var.admin_ssh_keys
  public_ip_id           = module.network.public_ip_ids["monitoring"]
  os_disk_config         = var.vm_os_disk_config
  source_image_reference = var.vm_source_image_reference
}

module "app_service" {
  source                  = "./modules/07_app_service"
  resource_group_name     = module.network.resource_group_name
  location                = var.location
  project_name            = var.project_name
  environment             = var.environment
  subnet_id               = module.network.services_subnet_id
  enable_vnet_integration = var.enable_app_service_vnet_integration
}