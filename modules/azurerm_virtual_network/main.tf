resource "azurerm_virtual_network" "samvnet" {
    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = var.address_space
}

