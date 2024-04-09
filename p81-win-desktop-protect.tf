# VM Windows -----------------------------------------------------------
resource "azurerm_windows_virtual_machine" "p81_win_protect" {
  name                = "p81-win-protect"
  resource_group_name = azurerm_resource_group.perimeter81_rsg.name
  location            = azurerm_resource_group.perimeter81_rsg.location
  size                = "Standard_B1s"
  admin_username      = "p81admin"
  admin_password      = "Perimeter81!"
  network_interface_ids = [azurerm_network_interface.p81_win_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-pro"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "p81_win_nic" {
  name                = "p81-win-nic"
  location            = azurerm_resource_group.perimeter81_rsg.location
  resource_group_name = azurerm_resource_group.perimeter81_rsg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.p81_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.81.1.5"
    public_ip_address_id          = azurerm_public_ip.p81_win_public_ip.id

  }
}

resource "azurerm_public_ip" "p81_win_public_ip" {
  name                = "p81-win-public-ip"
  location            = "westeurope"
  resource_group_name = "perimeter81-rsg"
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface_security_group_association" "p81_win_ass_nsg" {
  network_interface_id      = azurerm_network_interface.p81_win_nic.id
  network_security_group_id = azurerm_network_security_group.p81_nsg.id
}
