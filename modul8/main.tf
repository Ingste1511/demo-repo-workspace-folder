
terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  # subscription_id hentes fra ARM_SUBSCRIPTION_ID
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location

  # Tagger gjør det enkelt å finne igjen egne ressurser i et delt abonnement
  tags = {
    student = var.student_id
    course  = "iac"
  }
}

module "network" {
  source              = "git::https://github.com/Ingste1511/demo-repo-workspace-folder.git//modules/network?ref=network-v1.1.0"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}
