data azurerm_subscription current {
}

# Create Project in Azure DevOps
resource azuredevops_project main {
  name       = var.application_full_name
  description        = var.application_description
}

# Create repositories
resource azuredevops_git_repository main {
  for_each   = var.git_repositories_list
  project_id = azuredevops_project.main.id
  name       = each.key
  initialization {
    init_type = "Clean"
  }
}

# Create Service Principal for AZDO
module "azure_ad_sp_azdo" {
  source                    = "git::https://github.com/0xdbe-terraform/terraform-azure-ad-service-principal.git?ref=v2.0.1"
  for_each                  = var.application_environment_list
  application_full_name     = var.application_full_name
  application_environment   = each.key
  service_principal_purpose = "azdo"
}

# Create Azure Resource Group
module "azure_resource_group" {
  source                  = "git::https://github.com/0xdbe-terraform/terraform-azure-resource-group.git?ref=v2.0.0"
  for_each                = var.application_environment_list
  azure_location          = var.azure_location
  application_full_name   = var.application_full_name
  application_short_name  = var.application_short_name
  application_environment = each.key
  contributors            = [module.azure_ad_sp_azdo[each.key].service_principal_id]
}

# Create a Service Connection for Azure Ressource Manager
resource azuredevops_serviceendpoint_azurerm main {
  for_each                  = var.application_environment_list
  project_id                = azuredevops_project.main.id
  service_endpoint_name     = "ServiceConnexion-${var.application_short_name}-${each.key}"
  credentials {
    # The service principal application Id (and not Service Principal Id)
    serviceprincipalid  = module.azure_ad_sp_azdo[each.key].application_id
    # The service principal secret
    serviceprincipalkey = module.azure_ad_sp_azdo[each.key].service_principal_key
  }
  azurerm_spn_tenantid      = data.azurerm_subscription.current.tenant_id
  azurerm_subscription_id   = data.azurerm_subscription.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}

# Create Terraform Backend
module "azure_blob_storage" {
  source                  = "git::https://github.com/0xdbe-terraform/terraform-azure-blob-storage.git?ref=v2.0.1"
  for_each                = var.application_environment_list
  azure_location          = var.azure_location
  application_full_name   = var.application_full_name
  application_short_name  = var.application_short_name
  application_environment = each.key
  resource_group_name     = module.azure_resource_group[each.key].name
  storage_container_name  = ["terraform"]
}

# Create variable group
resource azuredevops_variable_group main {
  for_each     = var.application_environment_list
  project_id   = azuredevops_project.main.id
  name         = "VarGroup-${var.application_short_name}-${each.key}"
  description  = "Groupe of variables for ${each.key}"
  allow_access = true

  variable {
    name  = "AZDO_SERVICE_CONNECTION_NAME"
    value = azuredevops_serviceendpoint_azurerm.main[each.key].service_endpoint_name
  }

  variable {
    name  = "AZURE_RESOURCE_GROUP_NAME"
    value = module.azure_resource_group[each.key].name
  }
  
  variable {
    name  = "AZURE_STORAGE_ACCOUNT_NAME"
    value = module.azure_blob_storage[each.key].name
  }
  
  variable {
    name     = "AZ_STORAGE_CONTAINER_NAME"
    value    = "terraform"
  }
}