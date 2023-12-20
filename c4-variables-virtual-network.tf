variable "vnet_name" {
  description = "Virtual network name"
  default     = "ansible-vnet"
}

variable "address_space" {
  description = "Address range for the vnet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet for virtual network"
  default     = "ansible-subnet-01"
}

variable "subnet_address" {
  description = "Address space of the subnets"
  default     = ["10.0.1.0/24"]
}

variable "count_nic" {
  description = "Number of public ip address"
  default     = 3
}

variable "subnets" {
  type    = list(string)
  default = ["subnet1", "subnet2", "subnet3"]
}
