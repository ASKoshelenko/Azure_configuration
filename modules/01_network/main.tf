resource "azurerm_virtual_network" "vnet" {
  name                = "net-vnet-${var.project_name}-${var.environment}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "net-snet-${var.project_name}-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes

  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "net-snet-db-${var.project_name}-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.db_subnet_address_prefix]
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

  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_route_table" "rt" {
  name                = "net-rt-${var.route_table_name}-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "routes" {
  count                  = length(var.routes)
  name                   = var.routes[count.index].name
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.rt.name
  address_prefix         = var.routes[count.index].address_prefix
  next_hop_type          = var.routes[count.index].next_hop_type
  next_hop_in_ip_address = var.routes[count.index].next_hop_in_ip_address

  depends_on = [azurerm_route_table.rt]
}

resource "azurerm_subnet_route_table_association" "main_subnet_route" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [azurerm_subnet.subnet, azurerm_route_table.rt]
}

resource "azurerm_subnet_route_table_association" "db_subnet_route" {
  subnet_id      = azurerm_subnet.db_subnet.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [azurerm_subnet.db_subnet, azurerm_route_table.rt]
}

resource "azurerm_public_ip" "public_ips" {
  for_each            = var.create_public_ips
  name                = "net-pip-${each.key}-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}