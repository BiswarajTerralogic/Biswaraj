resource "azurerm_resource_group" "app_interface" {
  name     = "app-interface"
  location = "local.location"
}

resource "azurerm_virtual_network" "app_interface" {
  name                = "app-interface"
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  resource_group_name = local.resource_group
}

resource "azurerm_network_interface" "app_interface" {
  name                = "app-interface"
  location            = local.location
  resource_group_name = local.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "Devopsvm002" {
  name                = "Devopsvm001"
  resource_group_name = local.resource_group
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "Biswaraj_1993"
  admin_password      = "Biswaraj@1993"
  network_interface_ids = [
    azurerm_network_interface.app_interface.id,
  ]


os_disk {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
} 

source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "16.04-LTS"
  version   = "latest"
}
}