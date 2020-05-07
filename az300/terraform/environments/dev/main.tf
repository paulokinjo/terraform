locals {
  env = {
    customer          = var.customer
    environment       = var.environment
    prefix            = var.resource_group
    resource_group    = var.resource_group
    location          = var.location
    subscription_id   = var.subscription_id
    tags = {
      owner                     = "paulokinjo@hotmail.com"
      budget                    = "free"
      product                   = "az300"
      environment               = "dev"
      type                      = "administrative"
    }
  }
}

data "azurerm_client_config" "current" {
}
