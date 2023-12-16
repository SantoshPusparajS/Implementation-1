resource "azurerm_linux_virtual_machine" "ansible-demo" {
  depends_on            = [azurerm_network_interface.ansible_network_interf, azurerm_storage_account.vm_storage_account]
  count                 = var.instance_size
  name                  = "ansible-demo-${count.index}"
  resource_group_name   = azurerm_resource_group.ansible_rg.name
  location              = azurerm_resource_group.ansible_rg.location
  network_interface_ids = [azurerm_network_interface.ansible_network_interf[count.index].id]
  size                  = var.virtual_machine_size
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("./ssh-key/terraform-azure.pub")
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vm_storage_account.primary_blob_endpoint
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
  admin_username = "azureuser"
  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = "latest"
  }
}
