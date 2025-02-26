output "dev_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.dev-linux-vm.public_ip
}

output "prod_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.prod-linux-vm.public_ip
}
