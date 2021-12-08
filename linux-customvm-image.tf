
# Create virtual machine

resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                             = "${var.vm_name}"
    computer_name                    = "${var.vm_name}-tfvm"
    location                         = data.azurerm_resource_group.mytfrg.location
    resource_group_name              = data.azurerm_resource_group.mytfrg.name
    network_interface_ids            = ["${azurerm_network_interface.myterraformnic.id}"]
    size                             = "${var.vm_size}"
    admin_username                   = "${var.username}"
    admin_password                   = "${var.password}"
    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true
    disable_password_authentication  = false

    storage_os_disk {
    name              = "mytfVM-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
    id = "${data.azurerm_image.mycustomvmimage.id}"
  }

    custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")

    
    tags = {
        environment = "${var.env}"
    }
}