variable "project_name" {
  type        = string
  default     = "dziioniis"
}

variable "region" {
  type        = string
  default     = "eu-north-1"
}

variable "workspace" {
  type        = string
  default     = "dev"
}

variable "organization" {
  type        = string
  default     = "dziioniis-organization"
}

locals {
  region = var.region
  project_name = "dziioniis"
  prefix = "${terraform.workspace}-${local.project_name}"
  organization = var.organization
}