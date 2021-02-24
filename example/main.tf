locals {
  azure_location               = "eastus"
  application_full_name        = "HelloWorld"
  application_short_name       = "HW"
  application_description      = "A simple demo app in Azure"
  application_environment_list = ["dev","test"]
  git_repositories_list        = ["infra", "app"]
}

module "azdo-project" {
  source                       = "git::https://github.com/0xdbe-terraform/terraform-azure-azdo-project.git?ref=v2.0.1"
  azure_location               = local.azure_location
  application_full_name        = local.application_full_name
  application_short_name       = local.application_short_name
  application_description      = local.application_description
  application_environment_list = local.application_environment_list
  git_repositories_list        = local.git_repositories_list
}
