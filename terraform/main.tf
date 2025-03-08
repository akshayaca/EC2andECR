provider "aws" {
  region = "us-east-1" # Change the region if needed
}

module "ecr" {
  source = "./ecr"
}

module "ec2" {
  source    = "./ec2"
  subnet_id = var.subnet_id
  vpc_id    = var.vpc_id
}