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
  azure_location               = "eastus"
  application_full_name        = "HelloWorld"
  application_short_name       = "HW"
  application_description      = "A simple demo app in Azure"
  git_repositories_list        = ["backend", "frontend"]
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
```

- Deploy

```
terraform apply
```

- Open https://dev.azure.com/ to see your new project