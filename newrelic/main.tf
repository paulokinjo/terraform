# Configure terraform
terraform {
  required_version = "~> 1.1.0"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">= 2.34.1"
    }
  }
}

# Configure the New Relic provider
provider "newrelic" {}

data "newrelic_entity" "app_name" {
  name   = "Newsletter"
  type   = "APPLICATION"
  domain = "APM"
}