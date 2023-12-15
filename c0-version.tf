terraform {
  required_version = "~> 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = var.resource_group_name
    storage_account_name = "your-storage-account"
    container_name       = "your-container"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {

  }
}
