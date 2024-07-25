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

variable "mysql_admin_username" {
  description = "The administrator username of the MySQL server"
  type        = string
}

variable "mysql_admin_password" {
  description = "The administrator password of the MySQL server"
  type        = string
  sensitive   = true
}

variable "mysql_sku_name" {
  description = "Specifies the SKU Name for the MySQL Server"
  type        = string
}

variable "mysql_version" {
  description = "Specifies the version of MySQL to use"
  type        = string
}

variable "db_subnet_id" {
  description = "The ID of the subnet to deploy the MySQL server in"
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone"
  type        = string
}

variable "private_dns_zone_link" {
  description = "The ID of the Private DNS Zone Link"
  type        = string
}