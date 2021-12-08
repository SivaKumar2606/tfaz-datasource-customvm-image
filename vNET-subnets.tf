
# Create virtual network

resource "azurerm_virtual_network" "myterraformvnet" {
    name                = "${var.vnet_name}"
    address_space       = ["${var.vnet_address}"]
    location            = data.azurerm_resource_group.mytfrg.location
    resource_group_name = data.azurerm_resource_group.mytfrg.name

    tags = {
        environment = "${var.env}"
    }
}

# Create subnet1
resource "azurerm_subnet" "myterraformsubnet1" {
    name                 = "${var.subnet1_name}"
    resource_group_name  = data.azurerm_resource_group.mytfrg.name
    virtual_network_name = azurerm_virtual_network.myterraformvnet.name
    address_prefixes     = ["${var.subnet1_prefix}"]
}

# Create subnet2
resource "azurerm_subnet" "myterraformsubnet2" {
    name                 = "${var.subnet2_name}"
    resource_group_name  = data.azurerm_resource_group.mytfrg.name
    virtual_network_name = azurerm_virtual_network.myterraformvnet.name
    address_prefixes     = ["${var.subnet2_prefix}"]
}

# Create subnet3
resource "azurerm_subnet" "myterraformsubnet3" {
    name                 = "${var.subnet3_name}"
    resource_group_name  = data.azurerm_resource_group.mytfrg.name
    virtual_network_name = azurerm_virtual_network.myterraformvnet.name
    address_prefixes     = ["${var.subnet3_prefix}"]
}