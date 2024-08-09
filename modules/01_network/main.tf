resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
}

resource "azurerm_virtual_network" "marathon_virtual_network" {
  name                = "vnet-${var.project_name}-${var.environment}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "services_subnet" {
  name                 = "snet-services-${var.project_name}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.marathon_virtual_network.name
  address_prefixes     = [var.services_subnet_address_prefix]
}

resource "azurerm_subnet" "mysql_subnet" {
  name                 = "snet-mysql-${var.project_name}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.marathon_virtual_network.name
  address_prefixes     = [var.mysql_subnet_address_prefix]
  service_endpoints    = ["Microsoft.Storage"]
  
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_route_table" "marathon_vnet_rt" {
  name                = "rt-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_route" "routes" {
  count                  = length(var.routes)
  name                   = var.routes[count.index].name
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.marathon_vnet_rt.name
  address_prefix         = var.routes[count.index].address_prefix
  next_hop_type          = var.routes[count.index].next_hop_type
  next_hop_in_ip_address = var.routes[count.index].next_hop_in_ip_address
}

resource "azurerm_subnet_route_table_association" "services_subnet_route" {
  subnet_id      = azurerm_subnet.services_subnet.id
  route_table_id = azurerm_route_table.marathon_vnet_rt.id
}

resource "azurerm_subnet_route_table_association" "mysql_subnet_route" {
  subnet_id      = azurerm_subnet.mysql_subnet.id
  route_table_id = azurerm_route_table.marathon_vnet_rt.id
}

resource "azurerm_public_ip" "public_ips" {
  for_each            = var.create_public_ips
  name                = "pip-${each.key}-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql" {
  name                  = "mysqldnslink"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = azurerm_virtual_network.marathon_virtual_network.id
  registration_enabled  = false
}