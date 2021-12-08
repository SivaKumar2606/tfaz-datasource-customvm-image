
# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group_name     = data.azurerm_resource_group.mytfrg.name
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = "diag${random_id.randomId.hex}"
    location                    =  data.azurerm_resource_group.mytfrg.location
    resource_group_name         =  data.azurerm_resource_group.mytfrg.name
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = "${var.env}"
    }
}

# Create stroage containerblob for sampledata
# Resource_group is not Called here. Please check Syntax
resource "azurerm_storage_container" "mystoragecontainer" {
    name                        = "${var.container_name}"
    storage_account_name        = azurerm_storage_account.mystorageaccount.name
    container_access_type       = "private"
}


