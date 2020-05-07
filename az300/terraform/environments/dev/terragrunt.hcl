include {
  path = find_in_parent_folders()
}

locals {
  product     = "az300"
  customer    = "dev"
  environment = "iac"

  // Azure Subscription: PayAsYouGo-azure.optiva.com
  common_vars = yamldecode(file("${find_in_parent_folders("common.yaml")}"))
  subscription_id = local.common_vars.subscription_id

  // Azure Region
  location = "southeastasia"
  // Azure Resource Group
  resource_group = "${local.product}-${local.customer}-${local.environment}"

  remote_state_config = {
    subscription_id      = local.subscription_id
    resource_group_name  = local.resource_group
    storage_account_name = "${local.product}${local.customer}${local.environment}"
    container_name       = "${local.resource_group}-terraform"
  }
}

remote_state {
  backend = "azurerm"
  config = merge(local.remote_state_config, {
    key = "${local.environment}.${path_relative_to_include()}.tfstate"
  })
}

inputs = {
  customer        = local.customer
  environment     = local.environment
  subscription_id = local.subscription_id
  location        = local.location
  resource_group  = local.resource_group

  infrastructure_state_config = merge(local.remote_state_config, {
    key = "${local.environment}.infrastructure.tfstate"
  })
}
