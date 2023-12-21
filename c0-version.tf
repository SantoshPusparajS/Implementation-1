terraform {
  required_version = "~> 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"
    }
  }
  backend "azurerm" {
    #create manually before executing terraform init command
    resource_group_name  = "ansible-rg-resources"
    storage_account_name = "implementation2109"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {

  }
}
