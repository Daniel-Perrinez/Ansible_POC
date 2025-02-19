# Create an EC2 instance
resource "aws_instance" "test-linux-vm" {
  # count                  = 1
  ami                    = "ami-06b21ccaeff8cd686" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = merge(local.tags,
    # { Name = "test-vm-[count.index]" }
  )
}




