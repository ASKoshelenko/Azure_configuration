variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "The Azure region where resources will be created"
}

variable "subnet_id" {
  description = "ID of the subnet where the VM will be placed"
}

variable "project_name" {
  description = "Name of the project, used in resource names"
}

variable "environment" {
  description = "Environment (dev, test, prod)"
}

variable "admin_username" {
  description = "Username for the VM"
}

variable "vm_size" {
  description = "Size of the virtual machine"
}