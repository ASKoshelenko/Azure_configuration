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

variable "subnet_id" {
  description = "ID of the subnet to integrate with App Service"
  type        = string
}

variable "enable_vnet_integration" {
  description = "Whether to enable VNet integration for the App Service"
  type        = bool
  default     = false
}