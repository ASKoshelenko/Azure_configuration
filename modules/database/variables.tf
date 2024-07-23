variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "The Azure region where resources will be created"
}

variable "project_name" {
  description = "Name of the project, used in resource names"
}

variable "environment" {
  description = "Environment (dev, test, prod)"
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
}

variable "mysql_version" {
  description = "The version of MySQL to use"
}