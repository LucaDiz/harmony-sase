#VM Linux Connector ----------------------------------------------------
resource "azurerm_linux_virtual_machine" "p81_connector" {
  name                  = "p81-connector"
  resource_group_name   = azurerm_resource_group.perimeter81_rsg.name
  location              = azurerm_resource_group.perimeter81_rsg.location
  size                  = "Standard_B2s"
  admin_username        = "p81admin"
  admin_password        = "Perimeter81!"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.p81_connector_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
#!/bin/bash
apt-get update
apt-get install -y curl dnsutils software-properties-common
EOF
  )
}

resource "azurerm_public_ip" "p81_connector_public_ip" {
  name                = "p81-connector-public-ip"
  location            = "westeurope"
  resource_group_name = "perimeter81-rsg"
  allocation_method   = "Static"
  sku                 = "Basic"
}


resource "azurerm_network_interface" "p81_connector_nic" {
  name                = "p81-connector-nic"
  location            = azurerm_resource_group.perimeter81_rsg.location
  resource_group_name = azurerm_resource_group.perimeter81_rsg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.p81_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.81.1.4"
    public_ip_address_id          = azurerm_public_ip.p81_connector_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "p81_connector_ass_nsg" {
  network_interface_id      = azurerm_network_interface.p81_connector_nic.id
  network_security_group_id = azurerm_network_security_group.p81_nsg.id
}
