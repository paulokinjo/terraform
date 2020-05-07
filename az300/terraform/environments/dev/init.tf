terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  version         = "~> 2.0.0"
  subscription_id = var.subscription_id
  features {}
}

provider "azurerm" {
  alias           = "core"
  version         = "~> 2.0.0"
  subscription_id = var.subscription_id
  features {}
}

provider "azuread" {
  version         = "~> 0.7"
  subscription_id = var.subscription_id
}

provider "null" {
}
