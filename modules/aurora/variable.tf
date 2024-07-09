variable project_name {
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