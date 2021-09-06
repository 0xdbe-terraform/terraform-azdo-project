locals {
  project_name         = "HelloWorld"
  project_description  = "A simple demo app in Azure"
  project_repositories = ["frontend", "backend"]
}

module "azdo-project" {
  source               = "../"
  project_name         = local.project_name
  project_description  = local.project_description
  project_repositories = local.project_repositories
}
