data "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = var.resource_group_name
}
resource "azurerm_linux_virtual_machine" "ram" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [data.azurerm_network_interface.nic.id]
  size               = var.size
  admin_username = var.admin_username
  admin_password = var.admin_password
   disable_password_authentication = false

source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
os_disk {
    caching           = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
}

