output "instance-public-ip" {
  value = resource.azurerm_linux_virtual_machine.ansible-demo[*].public_ip_address
}
