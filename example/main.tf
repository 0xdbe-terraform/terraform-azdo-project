module "azdo-project" {

  # import module from git repository
  source = "git::https://github.com/0xdbe-terraform/terraform-azure-azdo-project.git?ref=v0.1.0"

  # Modules vars
  project_name         = "Hello world"
  project_description  = "A first hello world application"
  project_repositories = ["infra", "app"]

}
