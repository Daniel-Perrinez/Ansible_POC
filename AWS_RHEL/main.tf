provider "aws" {
  region = var.aws_region
    # assume_role {
    # role_arn = "arn:aws:iam::905418106762:role/github-actions-role"
    # }
}

locals {
  project = "rhel_poc"
  region = var.aws_region

  tags = {
    Project = local.project
  }
}

resource "aws_key_pair" "rhel-key" {
  key_name   = "rhel-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCj3q6gUWM08re48q3XUf9CXWnz3SZ5WzeLvl2SbLvtHqfOyvnJViLchcxvVczYCABxTY79lRQ/ihF2atC5f15I2cFl54L0k6MjPO7qqBVrIS/zhbnaihunvgQNVbDl+zgyf8laoloAxxB/1B82GtEmVJYRICQxoYEZKq3PNg48TRDb7KidzkBDqSkyQZ0JxOLlaBfjdrFnbNj7gmmrkI/w6qq8GxzVz4y6tQKmcnJF24rrCtutcM2hHPbIgFcXNFFlnE0B1A0PNQtyAKcXb/ISgZTEgDpzDtsHqbF2+oMiEG8BqMyRev5cYPWuPEBplZQrdkZUStIO8LsoqkrWvjmD danielperrinez@Operators-MacBook-Pro.local"
}

resource "tls_private_key" "rhel-rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

# resource "local_file" "rhel-pem" {
#   content = tls_private_key.rhel-rsa.private_key_pem
#   filename = "rhel-key.pem"
# }

resource "aws_instance" "RHEL_9_ec2" {
  depends_on = [ aws_key_pair.rhel-key, aws_security_group.ssh_sg ]
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.rhel_subnet.id
  key_name      = "rhel-key"
  vpc_security_group_ids = [ aws_security_group.ssh_sg.id ]

  tags = local.tags
}

resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg"
  description = "ssh security group"
  depends_on = [ aws_vpc.rhel_vpc ]
  vpc_id = aws_vpc.rhel_vpc.id

  # Ingress rule for SSH (port 22)
  # Allow IPv4 ICMP Echo Request
ingress                = [
  {
      cidr_blocks      = [
          "0.0.0.0/0",
        ]
      description      = ""
      from_port        = 8
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = -1
    },
  {
      cidr_blocks      = [
          "0.0.0.0/0",
        ]
      description      = "Allow IPv4 ICMP Echo Request"
      from_port        = 8
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  {
      cidr_blocks      = [
          "0.0.0.0/0",
        ]
      description      = "Allow ssh"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
  ]

  # Egress rule allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

# Create a VPC
resource "aws_vpc" "rhel_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = local.tags
}

# Create a subnet within the VPC
resource "aws_subnet" "rhel_subnet" {
  depends_on = [ aws_vpc.rhel_vpc ]
  vpc_id            = aws_vpc.rhel_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = local.tags
}


resource "aws_internet_gateway" "Ansible_igw" {
  vpc_id = aws_vpc.rhel_vpc.id

  tags = {
    Name = "ansible_igw"
    Project = local.project
  }
}