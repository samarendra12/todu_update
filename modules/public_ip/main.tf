 resource "azurerm_public_ip" "public" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}