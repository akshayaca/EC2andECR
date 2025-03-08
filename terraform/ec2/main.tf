data "aws_vpc" "default" {
  default = true
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub") # Ensure this is the correct path to your local public key
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow Kubernetes, HTTP, MySQL, and SSH access"
  vpc_id      = data.aws_vpc.default.id

  # Allow NodePort traffic
  ingress {
    description = "Kubernetes NodePort Service (30000)"
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Kubernetes API communication
  ingress {
    description = "Kubernetes API Server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow MySQL
  ingress {
    description = "MySQL communication within VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH
  ingress {
    description = "SSH for admin access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow HTTP access
  ingress {
    description = "HTTP for webserver"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
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
  instance_type          = "t3.medium" # Increased instance size
  subnet_id              = var.subnet_id
  security_groups        = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name               = aws_key_pair.terraform_key.key_name
  iam_instance_profile   = "LabInstanceProfile" # Your AWS Canvas IAM role

  tags = {
    Name = "Terraform-K8s-EC2"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl enable docker && systemctl start docker
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
    chmod +x kind && mv kind /usr/local/bin/
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl && mv kubectl /usr/local/bin/
  EOF
}
