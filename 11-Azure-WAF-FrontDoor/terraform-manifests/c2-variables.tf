# Input Variables
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "prefix" {
  description = "Prefix used for all resources"
  type        = string
  default     = "demo"
}

variable "vm_or_appservice_id" {
  description = "ID of the VM or App Service to install Azure Monitor Agent"
  type        = string
  default     = ""
}
