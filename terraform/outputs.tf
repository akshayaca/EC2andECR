output "ec2_security_group_id" {
  value = module.ec2.ec2_security_group_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "webapp_repo_uri" {
  value = module.ecr.webapp_repo_url
}

output "mysql_repo_uri" {
  value = module.ecr.mysql_repo_url
}