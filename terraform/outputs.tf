output "webapp_repo_uri" {
  value       = module.ecr.webapp_repo_url
  description = "Web application ECR repository URL"
}

output "mysql_repo_uri" {
  value       = module.ecr.mysql_repo_url
  description = "MySQL ECR repository URL"
}

output "ec2_public_ip" {
  value       = module.ec2.public_ip
  description = "Public IP address of the EC2 instance"
}
