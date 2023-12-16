variable "storage_account_name" {
  description = "Storage Account name in which terraform state file needs to store"
  default     = "implementation210996"
}

# variable "storage_container_name" {
#   description = "Container name for the storage account"
#   default     = "terraform"
# }

variable "storage_account_type" {
  description = "Storage account type"
  default     = "Standard_LRS"
}
