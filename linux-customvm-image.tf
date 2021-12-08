

# Create virtual machine for Custom Image

resource "azurerm_virtual_machine" "myterraformvm" {
    name                             = "${var.vm_name}"
    location                         = data.azurerm_resource_group.mytfrg.location
    resource_group_name              = data.azurerm_resource_group.mytfrg.name
    network_interface_ids            = ["${azurerm_network_interface.myterraformnic.id}"]
    vm_size                          = "Standard_B1s"
    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true
   
    storage_os_disk {
    name              = "mytfVM-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
      id = "${data.azurerm_image.mycustomvmimage.id}"
  }

    os_profile {
     computer_name                    = "${var.vm_name}-tfvm"
     admin_username                   = "${var.username}"
     admin_password                   = "${var.password}"

  }

    os_profile_linux_config {
      disable_password_authentication = false
  }

      
    tags = {
        environment = "${var.env}"
    }
}
