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
  filename = "rhel_.pem"
}

resource "aws_instance" "RHEL_9_ec2" {
  depends_on = [ aws_key_pair.rhel-key ]
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0576679eaf3324036"
  key_name      = "rhel-key"

  tags = {
    Name = local.name
  }
}