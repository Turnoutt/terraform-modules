terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "~>0.7.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.5.0"
    }
  }
  required_version = ">= 0.13"
}
