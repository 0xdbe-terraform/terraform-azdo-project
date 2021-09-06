variable "project_name" {
  type        = string
  description = "Name of your project"
}

variable "project_description" {
  type        = string
  description = "Description of your project"
}

variable "project_repositories" {
  type        = set(string)
  description = "list of repositories for this project"
}