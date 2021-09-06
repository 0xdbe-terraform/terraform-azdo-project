# Terraform Azure AZDO Project

This module for Terraform allows to bootstrap a project on Azure DevOps with repositories.

## Usage

- Set Azure DevOps variable

```console
$ export AZDO_PERSONAL_ACCESS_TOKEN=<PAT>
$ export AZDO_ORG_SERVICE_URL=https://dev.azure.com/<ORGANIZATION>/
```

- Import module

```hcl
locals {
  project_name         = "HelloWorld"
  project_description  = "A simple demo app in Azure"
  project_repositories = ["frontend", "backend"]
}

module "azdo-project" {
  source               = "git::https://github.com/0xdbe-terraform/terraform-azure-azdo-project.git?ref=v3.0.1"
  project_name         = local.project_name
  project_description  = local.project_description
  project_repositories = local.project_repositories
}
```

- Deploy

```
terraform apply
```

- Open https://dev.azure.com/ to see your new project