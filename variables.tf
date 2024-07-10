variable "project_name" {
  type        = string
  default     = "dziioniis"
}

variable "region" {
  type        = string
}

variable "workspace" {
  type        = string
}

variable "organization" {
  type        = string
}

locals {
  region = var.region
  project_name = "dziioniis"
  prefix = "${terraform.workspace}-${local.project_name}"
  organization = var.organization
}