resource "azurerm_virtual_network" "virtual_network_1" {
  depends_on          = [azurerm_resource_group.ansible_rg]
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.ansible_rg.name
  address_space       = var.address_space
  location            = azurerm_resource_group.ansible_rg.location

  tags = {
    "created_by"  = "santosh pusparaj"
    "environment" = "development"
  }
}

resource "azurerm_subnet" "subnet-01" {
  count                = length(var.subnets)
  name                 = "var.subnet_name-${count.index}"
  resource_group_name  = azurerm_resource_group.ansible_rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network_1.name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
}

resource "azurerm_network_interface" "ansible_network_interf" {
  depends_on          = [azurerm_public_ip.public_ip]
  count               = var.count_nic
  name                = "ansible-nic-${count.index}"
  location            = azurerm_resource_group.ansible_rg.location
  resource_group_name = azurerm_resource_group.ansible_rg.name

  ip_configuration {
    name                          = "public-ip"
    subnet_id                     = azurerm_subnet.subnet-01[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}


resource "azurerm_public_ip" "public_ip" {
  count               = var.count_nic
  name                = "public-ip-${count.index}"
  resource_group_name = azurerm_resource_group.ansible_rg.name
  location            = azurerm_resource_group.ansible_rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "development"
  }
}

