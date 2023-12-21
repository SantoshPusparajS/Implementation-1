output "instance-public-ip" {
  value = resource.azurerm_linux_virtual_machine.ansible-demo[*].public_ip_address
}

output "private_ip_addresses" {
  value = azurerm_network_interface.ansible_network_interf[*].private_ip_address
}

output "private_ip_addresses_as_string_op" {
  value = join(" ", azurerm_network_interface.ansible_network_interf[*].private_ip_address)
}
# output "private_ip_addresses" {
#   value = [for nic in azurerm_network_interface.ansible_network_interf : tostring(nic.private_ip_address)]
# }
