# Create an EC2 instance
resource "aws_instance" "test-linux-vm" {
  ami                    = "ami-06b21ccaeff8cd686" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.ansible_ssh_key.key_name
  
  associate_public_ip_address = true

  tags = merge(local.tags,
    { Name = "Linux Box" }
  )
}




