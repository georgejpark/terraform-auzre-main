variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vm_size" {
  description = "Size of virtual machines or plans"
  type        = string
  default     = "Standard_B1s"
}

variable "monitoring_enabled" {
  description = "Enable monitoring"
  type        = bool
  default     = true
}
