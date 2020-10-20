variable "azure_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource in Azure (default: 'eastus', less expensive location)"
}

variable "application_full_name" {
  type        = string
  description = "Name of your project, application, product or service."
}

variable "application_short_name" {
  type        = string
  description = "Short name of your application using abbreviations or acronyms."
  validation {
    condition     = can(regex("^\\w+$", var.application_short_name))
    error_message = "Application short name can only consist of letters and numbers."
  }
}

variable "application_environment_list" {
  type        = set(string)
  default     = ["dev","test","prod"]
  description = "Name of the environment (example: dev, test, prod, ...)"
}

variable "application_description" {
  type        = string
  description = "Description of your project, application, product or service"
}

variable "git_repositories_list" {
  type        = set(string)
  default     = ["infra","backend","frontend"]
  description = "list of repositories for this application, product or service"
}