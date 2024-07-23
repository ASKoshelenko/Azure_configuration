variable "location" {
  description = "The Azure region where resources will be created"
  default     = "North Europe"
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
  default     = "Standard_B1s"
}

variable "mysql_admin_username" {
  description = "Username for MySQL admin"
}

variable "mysql_admin_password" {
  description = "Password for MySQL admin"
  sensitive   = true
}

variable "mysql_sku_name" {
  description = "The SKU Name for the MySQL Flexible Server"
  default     = "B_Standard_B1s"
}

variable "mysql_version" {
  description = "The version of MySQL to use"
  default     = "8.0.21"
}

variable "ssh_public_key" {
  description = "The public SSH key to use for VMs"
  type        = string
}