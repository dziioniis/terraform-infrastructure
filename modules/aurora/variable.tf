variable project_name {
  type = string
}

variable "database_username" {
  type = string
}

variable prefix {
  type = string
}

variable subnet_ids {
  type = list(string)
}

variable vpc_id {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "db_instance_class" {
  type = string
}
