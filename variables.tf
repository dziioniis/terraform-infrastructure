variable "PROJECT_NAME" {
  type        = string
  default     = "dziioniis"
}

variable "REGION" {
  type        = string
}

variable "organization" {
  type        = string
}

locals {
  region = var.REGION
  project_name = "dziioniis"
  prefix = "${terraform.workspace}-${local.project_name}"
  organization = var.organization
}