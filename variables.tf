variable "project_name" {
  type = string
  description = "Name of your project or application"
}

variable "project_description" {
  type = string
  description = "Description of your project or application"
}

variable "project_repositories" {
  type    = set(string)
  description = "list of repositories need for this project or application"
  default = ["infra","backend","frontend"]
}
