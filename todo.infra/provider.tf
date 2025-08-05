terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
  backend "azurerm" {
    resource_group_name  =  "sagar"
    storage_account_name = "4204204"                              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "gautam"                               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "group.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  } 
}

provider "azurerm" {
    features {}
    subscription_id = "bcf304d8-21b8-4358-9c77-54b5dd26f938"
  # Configuration options
}
