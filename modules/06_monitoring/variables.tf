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

variable "admin_ssh_key" {
  description = "The public SSH key for the VM"
  type        = string
}

variable "public_ip_id" {
  description = "ID of the public IP to associate with the VM"
  type        = string
}