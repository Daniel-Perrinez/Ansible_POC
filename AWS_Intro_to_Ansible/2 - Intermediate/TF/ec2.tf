# Create an EC2 instance
resource "aws_instance" "dev-linux-vm" {
  ami                    = "ami-06b21ccaeff8cd686" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ansible_public_subnet.id
  vpc_security_group_ids = [aws_security_group.flask_app_sg.id]
  key_name               = aws_key_pair.ansible_ssh_key.key_name

  associate_public_ip_address = true

  tags = merge(local.tags,
    { 
      Name = "Intermediate - Dev Linux Box"
      Environment = "Development"
    }
  )
}

resource "aws_instance" "prod-linux-vm" {
  ami                    = "ami-06b21ccaeff8cd686" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ansible_public_subnet.id
  vpc_security_group_ids = [aws_security_group.flask_app_sg.id]
  key_name               = aws_key_pair.ansible_ssh_key.key_name

  associate_public_ip_address = true

  tags = merge(local.tags,
    { 
      Name = "Intermediate - Prod Linux Box"
      Environment = "Production"
    }
  )
}




