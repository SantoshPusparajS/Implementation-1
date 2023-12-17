resource "azurerm_storage_account" "vm_storage_account" {
  depends_on               = [azurerm_resource_group.ansible_rg]
  name                     = var.storage_account_name
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
