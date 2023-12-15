resource "azurerm_linux_virtual_machine" "ansible-demo" {
  depends_on            = [azurerm_network_interface.ansible_network_interf]
  count                 = 3
  name                  = "ansible-demo-${count.index}"
  resource_group_name   = azurerm_resource_group.ansible_rg.name
  location              = azurerm_resource_group.ansible_rg.location
  network_interface_ids = [azurerm_network_interface.ansible_network_interf[count.index].id]
  size                  = "Standard_DS1_v2"
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("./ssh-key/terraform-azure.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_username = "azureuser"
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
