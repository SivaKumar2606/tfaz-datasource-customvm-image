
# 1. Output Values - Virtual Machine - IP Address
output "vm_public_ip_address" {
  description = "My Virtual Machine Public IP"
  value = azurerm_public_ip.myterraformpublicip.ip_address
}

# 2. Name of VM
output "vm_name" {
    description = "Name of the VM"
    value = azurerm_virtual_machine.myterraformvm.name
}

# 3. Output Values - Virtual Machine Resource Group Name
output "vm_resource_group_name" {
  description = "My Virtual Machine Resource Group Name"
  value = data.azurerm_resource_group.mytfrg.name

}

# 4. Output Values - Virtual Machine Location
output "vm_resource_group_location" {
  description = "My Virtual Machine Location"
  value = data.azurerm_resource_group.mytfrg.location
}

# 5. Output Values - Virtual Machine Network Interface ID
output "vm_network_interface_ids" {
  description = "My Virtual Machine Network Interface IDs"
  value = [azurerm_virtual_machine.myterraformvm.network_interface_ids]
}

