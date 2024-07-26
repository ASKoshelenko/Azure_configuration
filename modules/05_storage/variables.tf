variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, test, prod)"
  type        = string
}

variable "storage_config" {
  description = "Configuration for the storage account"
  type = object({
    account_tier             = string
    account_replication_type = string
    container_name           = string
  })
}