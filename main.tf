provider "aws" {
  region = "eu-west-1"
}

terraform {
  cloud {
    organization = "dziioniis-organization"

    workspaces {
      name = "dev"
    }
  }

 required_providers {
   aws = {
     source = "hashicorp/aws"
     version = "5.50.0"
   }
 }

  backend "s3" {
    bucket = "terraform-state-bucket-dziioniis"
    key = "terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
    secret_key = "SgWXBE1YznOClfsCuST99MMW4DL+Cp5GJjxCTNsM"
  }
}

module "networking" {
  source = "./modules/networking"
}

module "postgres" {
   source  = "./modules/aurora"
   project_name = var.project_name 
   prefix = local.prefix
   subnet_ids = [module.networking.public_subnet_id, module.networking.private_subnet_id]
   vpc_id = module.networking.vpc_id
   vpc_cidr_block = module.networking.vpc_cidr_block
}
