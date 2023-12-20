output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = resource.azurerm_virtual_network.virtual_network_1.address_space
}

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = resource.azurerm_virtual_network.virtual_network_1.id
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = resource.azurerm_virtual_network.virtual_network_1.location
}

output "vnet_name" {
  description = "The name of the newly created vNet"
  value       = resource.azurerm_virtual_network.virtual_network_1.name
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = resource.azurerm_subnet.subnet-01[*].id
}
