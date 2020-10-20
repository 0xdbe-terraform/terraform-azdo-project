# Terraform Azure AZDO Project

This module for Terraform allows to bootstrap a project on Azure DevOps with :

- Git repositories
- Service connexion to Azure
- Resource Group
- Service Principal (with Contributor role on Resource Group)
- Azure Storage as remote backend for Terraform

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
  application_environment_list = ["dev","test"]
  git_repositories_list        = ["infra", "app"]
}

module "azdo-project" {
  source                       = "git::https://github.com/0xdbe-terraform/terraform-azure-azdo-project.git?ref=v2.0.0"
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

## To Do

What still needs to be done:

- [ ] AZDO features selection: boards, repositories, pipelines, testplans, artifacts
- [ ] Avoid creation of the first default git repository
- [ ] Avoid creation of terraform backend and use terraform init to create this backend
