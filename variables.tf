variable "project_name" {
  type        = string
  default     = "dziioniis"
}

variable "region" {
  type        = string
  default     = "eu-north-1"
}

locals {
  region = "eu-north-1"
  project_name = "dziioniis"
  prefix = "${terraform.workspace}-${local.project_name}"
}