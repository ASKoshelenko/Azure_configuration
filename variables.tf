variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "North Europe"
}

variable "project_name" {
  description = "Name of the project, used in resource names"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "db_subnet_address_prefix" {
  description = "The address prefix to use for the database subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "vm_config" {
  description = "Configuration for the VM"
  type = object({
    size           = string
    admin_username = string
  })
  default = {
    size           = "Standard_B1s"
    admin_username = "azureuser"
  }
}

variable "mysql_config" {
  description = "Configuration for MySQL"
  type = object({
    admin_username = string
    admin_password = string
    sku_name       = string
    version        = string
  })
  sensitive = true
}

variable "storage_config" {
  description = "Configuration for storage account"
  type = object({
    account_tier             = string
    account_replication_type = string
    container_name           = string
  })
  default = {
    account_tier             = "Standard"
    account_replication_type = "LRS"
    container_name           = "mycontainer"
  }
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
  default     = "main-route-table"
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

variable "admin_ssh_key" {
  description = "The public SSH key for the VMs"
  type        = string
}

variable "create_public_ips" {
  description = "Map of public IPs to create"
  type = map(object({
    allocation_method = string
    sku               = string
  }))
  default = {
    "vm" = {
      allocation_method = "Dynamic"
      sku               = "Basic"
    },
    "monitoring" = {
      allocation_method = "Dynamic"
      sku               = "Basic"
    }
  }
}

variable "vm_os_disk_config" {
  description = "OS disk configuration for VMs"
  type = object({
    caching              = string
    storage_account_type = string
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

variable "vm_source_image_reference" {
  description = "Source image reference for VMs"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }
}