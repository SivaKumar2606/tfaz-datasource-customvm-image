
# Locate the Existing Resource Group

data "azurerm_resource_group" "mytfrg" {
       name     = "TerraformRG"
    }

output "id" {
  value = data.azurerm_resource_group.mytfrg.id
}

# Locate the existing custom image
data "azurerm_image" "mycustomvmimage" {
  name                = "worker-machine-Terraform-azcli-image-20211206204327"
  resource_group_name = "TerraformRG"
}

output "image_id" {
  value = "/subscriptions/f949bc7c-3156-4172-9de7-75d9049123a8/resourceGroups/TerraformRG/providers/Microsoft.Compute/images/worker-machine-Terraform-azcli-image-20211206204327"
}
