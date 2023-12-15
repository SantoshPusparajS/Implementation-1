variable "storage_account_name" {
  description = "Storage Account name in which terraform state file needs to store"
  default     = "implementation2109"
}

variable "storage_container_name" {
  description = "Container name for the storage account"
  default     = "terraform"
}
