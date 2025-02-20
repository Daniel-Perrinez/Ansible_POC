# Create a VPC
resource "aws_vpc" "ansible_vpc" {

  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags,
    { Name = "ansible-vpc" }
  )
}

# Create a subnet
resource "aws_subnet" "ansible_public_subnet" {
  vpc_id     = aws_vpc.ansible_vpc.id
  cidr_block = "10.0.1.0/24"
  

  tags = merge(local.tags,
    { Name = "ansible-public-subnet" }
  )
}

# Create a security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.ansible_vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags,
    { Name = "ansible-sg" }
  )
}

resource "aws_security_group_rule" "allow_ping" {
  type        = "ingress"
  from_port   = 8
  to_port     = 0
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow ping from anywhere (adjust as needed)
  security_group_id = aws_security_group.allow_ssh.id

  description = "Allow ICMP ping"
}


# resource "aws_eip" "ansible_eip_lb" {
#   instance = aws_instance.test-linux-vm.id
#   domain   = "vpc"
#   public_ip = ""

#   tags = merge(local.tags,
#     { Name = "ansible-eip-lb" }
#   )
# }

resource "aws_internet_gateway" "ansible_gw" {
  vpc_id = aws_vpc.ansible_vpc.id

  tags = {
    Name = "ansible_gw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ansible_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ansible_gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.ansible_public_subnet.id
  route_table_id = aws_route_table.public.id
}


resource "aws_key_pair" "ansible_ssh_key" {
  key_name   = "ansible-ssh-key"
  public_key = file("../../../creds/id_rsa.pub")
}
