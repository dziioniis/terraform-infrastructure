variable "project_name" {
  type        = string
  default     = "dziioniis"
}

variable "region" {
  type        = string
  default     = "eu-west-3"
}

locals {
  region = "eu-west-3"
  project_name = "dziioniis"
  prefix = "${terraform.workspace}-${local.project_name}"
}