# Create Project in Azure DevOps
resource azuredevops_project main {
  name         = var.project_name
  description  = var.project_description
}

# Create repositories
resource azuredevops_git_repository main {
  for_each   = var.project_repositories
  project_id = azuredevops_project.main.id
  name       = each.key
  initialization {
    init_type = "Clean"
  }
}
