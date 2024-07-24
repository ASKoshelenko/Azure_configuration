location                 = "North Europe"
project_name             = "itmarathon"
environment              = "dev"
vnet_address_space       = ["10.0.0.0/16"]
subnet_address_prefixes  = ["10.0.1.0/24"]
db_subnet_address_prefix = "10.0.2.0/24"

vm_config = {
  size           = "Standard_B1s"
  admin_username = "azureuser"
}

mysql_config = {
  admin_username = "mysqladmin"
  admin_password = "Pa$$w0rd134!"
  sku_name       = "B_Standard_B1s"
  version        = "8.0.21"
}

storage_config = {
  account_tier             = "Standard"
  account_replication_type = "LRS"
  container_name           = "itmarathoncontainer"
}

route_table_name = "main-route-table"
routes = [
  {
    name                   = "route-to-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name                   = "route-to-datacenter"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.1.4"
  }
]

admin_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0WGP1EZfreNQiPfViHCKnLs..."