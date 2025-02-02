output "public_ip" {
  value       = aws_instance.ec2_instance.public_ip
  description = "Public IP address of the EC2 instance"
}

output "ec2_security_group_id" {
  value       = aws_security_group.ec2_sg.id
  description = "ID of the EC2 security group"
}
