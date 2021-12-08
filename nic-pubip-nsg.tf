
# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                    = "${var.mypip}"
    location                = data.azurerm_resource_group.mytfrg.location
    resource_group_name     = data.azurerm_resource_group.mytfrg.name
    allocation_method       = "Dynamic"

    tags = {
        environment = "${var.env}"
    }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    name                      = "myNIC"
    location                  = data.azurerm_resource_group.mytfrg.location
    resource_group_name       = data.azurerm_resource_group.mytfrg.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = "${var.env}"
    }
}


# Create Network Security Group and rule for SSH

resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "${var.nsg_name}"
    location            = data.azurerm_resource_group.mytfrg.location
    resource_group_name = data.azurerm_resource_group.mytfrg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "${var.env}"
    }
}

# Creating Additional NSG Rule - Custom

resource "azurerm_network_security_rule" "mytfnsgrule" {
  name                        = "Allow-HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.mytfrg.name
  network_security_group_name = azurerm_network_security_group.myterraformnsg.name
}


# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}