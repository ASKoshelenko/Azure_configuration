variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "project_name" {
  description = "Name of the project, used in resource names"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "create_public_ips" {
  description = "Map of public IPs to create"
  type = map(object({
    allocation_method = string
    sku               = string
  }))
  default = {}
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
  default     = "default-route-table"
}

variable "routes" {
  description = "List of routes to be added to the route table"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
  default = []
}

variable "db_subnet_address_prefix" {
  description = "The address prefix to use for the database subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "route_to_db" {
  description = "Route to the database subnet"
  type = object({
    name           = string
    address_prefix = string
  })
  default = {
    name           = "route_to_db"
    address_prefix = "10.0.2.0/24"
  }
}