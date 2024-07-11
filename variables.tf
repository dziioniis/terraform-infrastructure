variable "PROJECT_NAME" {
  type        = string
  default     = "dziioniis"
}

variable "region" {
  type        = string
  default = ""
}

locals {
  region = var.region
  project_name = "dziioniis"
  prefix = "${terraform.workspace}-${local.project_name}"
}