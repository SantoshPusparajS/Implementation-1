variable "resource_group_name" {
  description = "Resource group name"

  default = "ansible-rg-resources"
}

variable "resource_group_location" {
  description = "Location in which the resource needs to created"
  default     = "eastus"
}

variable "virtual_machine_size" {
  description = "VM size"
  default     = "Standard_DS1_v2"
}

variable "instance_size" {
  description = "Number of Virtual Machines"
  default     = 3
}

variable "source_image_publisher" {
  description = "Publisher of the os"
  default     = "Canonical"
}

variable "source_image_sku" {
  description = "SKU of the source image"
  default     = "22_04-lts"
}

variable "source_image_offer" {
  description = "source image offer"
  default     = "0001-com-ubuntu-server-jammy"
}
