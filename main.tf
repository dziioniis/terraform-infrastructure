provider "aws" {
  region = local.region
}

terraform {
  cloud {
    organization = "dziioniis-organization"
  }

 required_providers {
   aws = {
     source = "hashicorp/aws"
     version = "5.50.0"
   }
 }
}

module "networking" {
  source = "./modules/networking"
}

module "postgres" {
   source  = "./modules/aurora"
   project_name = local.project_name 
   prefix = local.prefix
   subnet_ids = [module.networking.public_subnet_id, module.networking.private_subnet_id]
   vpc_id = module.networking.vpc_id
   vpc_cidr_block = module.networking.vpc_cidr_block
   database_username = local.database_username
   db_instance_class = local.db_instance_class
}
