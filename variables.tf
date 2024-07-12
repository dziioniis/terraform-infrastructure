variable "project_name" {
  type        = string
}

variable "region" {
  type = string
}

variable "database_username" {
  type = string
}

variable "db_instance_class" {
  type = string
}

locals {
  region = var.region
  project_name = var.project_name
  prefix = "${terraform.workspace}-${local.project_name}"
  database_username = var.database_username
  db_instance_class = var.db_instance_class
}
