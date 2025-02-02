data "aws_vpc" "default" {
  default = true
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub") # Ensure this is the correct path to your local public key
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow HTTP, MySQL, and SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP traffic for app on 8081"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP traffic for app on 8082"
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP traffic for app on 8083"
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL communication within VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH for admin access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "HTTP for webserver"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-security-group"
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  security_groups         = [aws_security_group.ec2_sg.id] # Reference security group
  associate_public_ip_address = true
  key_name               = aws_key_pair.terraform_key.key_name
  iam_instance_profile   = "LabInstanceProfile" # Replace with your IAM role

  tags = {
    Name = "Terraform-EC2-Instance"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    service docker start
  EOF
}


# resource "aws_instance" "ec2_instance" {
#   ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
#   instance_type = "t2.micro"
#   subnet_id     = var.subnet_id
#   security_groups = [aws_security_group.ec2_sg.name]
#   associate_public_ip_address = true
#   iam_instance_profile = "LabInstanceProfile"

#   tags = {
#     Name = "Terraform-EC2-Instance"
#   }

#   user_data = <<-EOF
#     #!/bin/bash
#     yum update -y
#     yum install -y docker
#     service docker start
#   EOF
# }

# resource "aws_security_group" "ec2_sg" {
#   name        = "ec2_sg"
#   description = "Allow HTTP, MySQL, and SSH access"
#   vpc_id      = data.aws_vpc.default.id

#   ingress {
#     description = "HTTP traffic for app on 8081"
#     from_port   = 8081
#     to_port     = 8081
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP traffic for app on 8082"
#     from_port   = 8082
#     to_port     = 8082
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP traffic for app on 8083"
#     from_port   = 8083
#     to_port     = 8083
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "MySQL communication within VPC"
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = [data.aws_vpc.default.cidr_block]
#   }

#   ingress {
#     description = "SSH for admin access"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["18.234.68.186/32"]
#   }

#   egress {
#     description = "Allow all outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ec2-security-group"
#   }
# }
