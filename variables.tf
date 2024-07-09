variable "project_name" {
  type        = string
  default     = "dziioniis"
}

variable "region" {
  type        = string
  default     = "eu-west-2"
}

locals {
  region = "eu-west-2"
  project_name = "dziioniis"
  prefix = "${terraform.workspace}-${local.project_name}"
}