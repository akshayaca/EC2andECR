variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be deployed"
  default     = "vpc-0809a3b8b3458eb89" 
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be deployed"
  default     = "subnet-07413293a52542b3d" 
}
