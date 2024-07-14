variable "project_name" {
  type = string
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

variable "project_prefix" {
  type = string
}

locals {
  region = var.region
  project_name = var.project_name
  project_prefix = var.project_prefix
  resource_prefix = "${terraform.workspace}-${local.project_prefix}"
  database_username = var.database_username
  db_instance_class = var.db_instance_class
}
