resource "azurerm_virtual_network" "virtual_network_1" {
  depends_on          = [azurerm_resource_group.ansible_rg]
  name                = "ansible-vnet"
  resource_group_name = azurerm_resource_group.ansible_rg.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.ansible_rg.location

  tags = {
    "created_by"  = "santosh pusparaj"
    "environment" = "development"
  }
}

resource "azurerm_subnet" "subnet-01" {
  name                 = "ansible-subnet-01"
  resource_group_name  = azurerm_resource_group.ansible_rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network_1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "ansible_network_interf" {
  depends_on          = [azurerm_public_ip.public_ip]
  count               = 3
  name                = "ansible-nic-${count.index}"
  location            = azurerm_resource_group.ansible_rg.location
  resource_group_name = azurerm_resource_group.ansible_rg.name

  ip_configuration {
    name                          = "public-ip"
    subnet_id                     = azurerm_subnet.subnet-01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}


resource "azurerm_public_ip" "public_ip" {
  count               = 3
  name                = "public-ip-${count.index}"
  resource_group_name = azurerm_resource_group.ansible_rg.name
  location            = azurerm_resource_group.ansible_rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "development"
  }
}

