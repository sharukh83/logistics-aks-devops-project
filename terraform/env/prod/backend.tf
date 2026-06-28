terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "tfstatebackend123"
    container_name       = "tfstate"
    key                  = "prod.tfstate"
  }
}