variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
variable "DJANGO_SECRET_KEY_PROD" {}

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

  resource "azurem_container_registry" "emchargue-acr" {
    name = "acr_emchargueacmp2400"
    resource_group_name = "rg-emchargue"
    location = "Central US"
    sku = "Basic"
    admin_enabled = false
  }

resource "azurem_container_group" "emchargue-aci" {
  name = "acmp2400-emchargue-aci"
  location = "Central US"
  resource_group_name = "rg-emchargue"
  ip_address_type = "Public"
  dms_name_label = "acmp-emchargue-instance"
  os_type = "Linux"

  container {
    name = "final"
    image = "acr_emchargueacmp2400.azurecr.io/final:latest"
    cpu = "0.5"
    memory = "1.5"

  ports  {
    port = 8000
    protocol = "TCP"
    }

  secure_environment_variables = {
    DJANGO_SECRET_KEY = var.DJANGO_SECRET_KEY_PROD
  }

  image_registry_credential {
    server = "acemchargueacmp2400.azurecr.io"
    username = var ARM_CLIENT_ID
    password = var ARM_CLIENT_SECRET

  }
}
