
# Configure the Microsoft Azure Provider

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

# Redirecting .tfstate file to be saved on Existing Remote storage Backend Container account.
# Only Values are Accepted here. No Variable Reference Calls

backend "azurerm" {
  resource_group_name    = "TerraformRG"
  storage_account_name   = "remotestatefilestoacc01"
  container_name         = "tfbackendaccount"
  key                    = "terraform.tfstate"
 }

}

provider "azurerm" {
    client_id        = "${var.access_key}"
    client_secret    = "${var.secret_key}"
    subscription_id  = "${var.sub_id}"
    tenant_id        = "${var.tenant_id}"
    features {}
}

 
