# Terraform Azure AZDO Project

This module for Terraform allows to bootstrap a project on Azure DevOps :

- Create a project for your application with a first repository (using the project name)
- Create addtionnal repositories (such as infa, backend and frontend)

## Usage

- Set Azure DevOps variable

```console
$ export AZDO_PERSONAL_ACCESS_TOKEN=<PAT>
$ export AZDO_ORG_SERVICE_URL=https://dev.azure.com/<ORGANIZATION>/
```

- Import module

```hcl
module "azure-devops-bootstrap" {
  
  # Module source
  source = "git::https://github.com/0xdbe-terraform/terraform-azure-azdo-project.git?ref=v1.0.0"
  
  # Modules vars
  project_name         = "Hello World"
  project_description  = "application for testing purpose"
  project_repositories = ["infra","backend","frontend"]

}
```

- Deploy

```
terraform plan
terraform apply
```

- Open https://dev.azure.com/ to see your new project

## To Do

What still needs to be done:

- [ ] AZDO features selection: boards, repositories, pipelines, testplans, artifacts
- [ ] Avoid creation of the first repository using the project name
