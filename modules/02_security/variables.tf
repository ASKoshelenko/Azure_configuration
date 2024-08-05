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

variable "main_subnet_id" {
  description = "ID of the main subnet to associate with the NSG"
  type        = string
}

variable "monitoring_subnet_id" {
  description = "ID of the monitoring subnet to associate with the NSG"
  type        = string
}

variable "allowed_ip_range" {
  description = "The IP range allowed to access resources"
  type        = string
}

variable "create_nsg_associations" {
  description = "Whether to create NSG associations or not"
  type        = bool
  default     = true
}