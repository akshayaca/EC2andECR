provider "aws" {
  region = "us-east-1" # Change the region if needed
}

module "ecr" {
   source = "./ecr"
}


module "ec2" {
  source = "./ec2"
  subnet_id = "subnet-01fc542d9e479d056" # Replace with your public Subnet ID
  vpc_id   = "vpc-0bd2f93c15156dfff"     # Replace with your Default VPC ID
}
output "ec2_security_group_id" {
  value = module.ec2.ec2_security_group_id
}