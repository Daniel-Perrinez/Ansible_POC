provider "aws" {
  region = var.aws_region
    # assume_role {
    # role_arn = "arn:aws:iam::905418106762:role/github-actions-role"
    # }
}

locals {
  name   = "Ansible_Host_RHEL"
  region = var.aws_region

  tags = {
    Example    = local.name
  }
}

resource "aws_key_pair" "rhel-key" {
  key_name   = "rhel-key"
  public_key = tls_private_key.rhel-rsa.public_key_openssh
}

resource "tls_private_key" "rhel-rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "rhel-pem" {
  content = tls_private_key.rhel-rsa.private_key_pem
  filename = "rhel.pem"
}

resource "aws_instance" "RHEL_9_ec2" {
  depends_on = [ aws_key_pair.rhel-key, aws_security_group.ssh_sg ]
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.rhel_subnet.id
  key_name      = "rhel-key"
  vpc_security_group_ids = [ aws_security_group.ssh_sg.id ]

  tags = {
    Name = local.name
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg"
  description = "ssh security group"
  depends_on = [ aws_vpc.rhel_vpc ]
  vpc_id = aws_vpc.rhel_vpc.id

  # Ingress rule for SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rhel_poc"
  }
}

# Create a VPC
resource "aws_vpc" "rhel_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "rhel_poc"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "rhel_subnet" {
  depends_on = [ aws_vpc.rhel_vpc ]
  vpc_id            = aws_vpc.rhel_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "rhel_poc"
  }
}