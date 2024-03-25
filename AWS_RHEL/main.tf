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

resource "aws_instance" "RHEL_9_ec2" {
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0576679eaf3324036"

  tags = {
    Name = local.name
  }
}