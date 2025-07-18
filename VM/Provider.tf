terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.35.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "c5b5373d-d3eb-4a33-87bc-39cc3f127d94"
  features {}
}