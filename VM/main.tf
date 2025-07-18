resource "azurerm_resource_group" "rgs" {
  name     = "rg1"
  location = "centralindia"
}
resource "azurerm_virtual_network" "vnets" {
  name                = "vnet1"
  location            = "centralindia"
  resource_group_name = azurerm_resource_group.rgs.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "subnets" {
  name                 = "subnethajipur"
  resource_group_name  = azurerm_resource_group.rgs.name
  virtual_network_name = azurerm_virtual_network.vnets.name
  address_prefixes     = ["10.0.0.0/24"]
}
resource "azurerm_public_ip" "pips" {
  name                = "piptna"
  resource_group_name = azurerm_resource_group.rgs.name
  location            = azurerm_resource_group.rgs.location
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "nics" {
  name                = "nicptna"
  resource_group_name = azurerm_resource_group.rgs.name
  location            = "centralindia"
  ip_configuration {
    name                          = "ipc"
    subnet_id                     = azurerm_subnet.subnets.id
    public_ip_address_id          = azurerm_public_ip.pips.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_virtual_machine" "vms" {
  name                  = "vmptna"
  location              = azurerm_resource_group.rgs.location
  resource_group_name   = azurerm_resource_group.rgs.name
  network_interface_ids = [azurerm_network_interface.nics.id]
  vm_size               = "Standard_B2s"
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "Alok"
    admin_password = "Alok@123"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}