variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the VM will be placed"
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

variable "admin_username" {
  description = "Username for the VM"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "public_ip_id" {
  description = "The ID of the public IP address to associate with the VM"
  type        = string
}

variable "admin_ssh_keys" {
  description = "List of public SSH keys for VM access"
  type        = list(string)
}

variable "os_disk_config" {
  description = "OS disk configuration for VM"
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "source_image_reference" {
  description = "Source image reference for VM"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}