#Resource Group and VNET -----------------------------------------------------
resource "azurerm_resource_group" "perimeter81_rsg" {
  name     = "perimeter81-rsg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "p81-vnet"
  address_space       = ["10.81.0.0/16"]
  location            = azurerm_resource_group.perimeter81_rsg.location
  resource_group_name = azurerm_resource_group.perimeter81_rsg.name
}

resource "azurerm_subnet" "p81_subnet" {
  name                 = "p81-subnet"
  resource_group_name  = azurerm_resource_group.perimeter81_rsg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.81.1.0/24"]
}

resource "azurerm_network_security_group" "p81_nsg" {
  name                = "p81-nsg"
  location            = azurerm_resource_group.perimeter81_rsg.location
  resource_group_name = azurerm_resource_group.perimeter81_rsg.name

  security_rule {
    name                       = "allow-rdp-from-my-ip"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "TUO_IP_PUBBLICO/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ssh-from-my-ip"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "TUO_IP_PUBBLICO/32"
    destination_address_prefix = "*"
  }

}
