terraform {
  required_providers {
    azurers = {
      source = "hashicorp/azurers"
      version = "4.68.0"
    }
  }
  
  backend "azurem" {
    resource_group_name = "rg.acmp.final"
    storage_account_name = "acmp2400storageaccount"
    container_name = "big-tf-state-acmp2400"
    use_azuread_auth = true
  }

  provider "azurem" {
    features {}
  }

  resource "azurem_container_registry" "teacher-acr" {
    name = "emchargue"
    resource_group_name = "rg-emchargue"
    location = "Central US"
    sku = "Basic"
    admin_enabled = false
  }
