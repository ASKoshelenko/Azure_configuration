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

variable "services_subnet_id" {
  description = "ID of the services subnet to associate with the NSG"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to access resources"
  type        = list(string)
}