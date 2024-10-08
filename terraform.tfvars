location                        = "North Europe"
project_name                    = "itmarathon"
environment                     = "dev"
vnet_address_space              = ["10.0.0.0/16"]
services_subnet_address_prefix  = "10.0.1.0/24"
mysql_subnet_address_prefix     = "10.0.3.0/24"
allowed_ip_ranges = [
  "86.57.255.94/32",    # vpn-by.epam.com
  "213.184.231.20/32",  # vpn-by-minsk.epam.com
  "202.65.196.242/32",  # vpn-cn.epam.com
  "195.56.119.209/32",  # vpn-eu.epam.com
  "195.56.119.212/32",  # vpn-eu.epam.com
  "204.153.55.4/32",    # vpn-eu2.epam.com
  "203.170.48.2/32",    # vpn-in.epam.com
  "85.223.209.18/32",   # vpn-ua.epam.com
  "174.128.60.160/32",  # vpn-us.epam.com
  "174.128.60.162/32"   # vpn-us.epam.com
]
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

vm_config = {
  size           = "Standard_B1s"
  admin_username = "azureuser"
}

admin_ssh_keys = [
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmRls6iuufvsvdX603Rweeiti9YqWEmDmYcV/VmHAvtCyBqVkwYmqsSH+7BUMezR5DzZKB/hjJ+OiTvCHsnXyhG8+cbymdfL4FriCN+PergdfRFPEnFhMPqzws21Nkf9r6oBQZs36lFL4wZRxLw6cGYej/Fmpf2hUgfu24435/w1LX56XQmTBqntS3/80dEs/mNALT/qVuXpbD05zfo4L8ow72cUUII2I68eKySL1mHf/V8BemnzR7JagET1NNL4TI9Cah0C8LiAD2xs4l1mAaljNPoxmnCujACJdx7bQxnEOE5RHkYOfs+Tg5Chx/veVfqZ9WownschcRF2bMV8hYqot8JMo2MePMSoZA/DNyd+VL6IU/RQ1nnuMmD+bXFt59A063rPYkC9ttwEsnT+WWqFJRh0WqhQRUuiyXS0LaTcnIgthtk2T4dEfbeDjWuuySrYEEAkpVyWhFlTQDOIa/B5uUBxROPHIwil4Jl46sWK1nZvzJUA14fjT+uu2i4Xk= user@example.com",

]
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

enable_app_service_vnet_integration = false