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

variable "subnet_id" {
  description = "ID of the subnet to associate with the NSG"
}