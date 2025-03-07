# resource "aws_route53_zone" "dev" {
#   name = "wei-ansible-dev.com"
# }

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.dev.zone_id
#   name    = "www.wei-ansible-dev.com"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.dev-linux-vm.public_ip]
# }


# Public IPs and URLs for my Ansible lunch and learn
# DEV - 34.229.132.203 --> http://ec2-34-229-132-203.compute-1.amazonaws.com
# PROD - 3.227.240.148 -->  http://ec2-3-227-240-148.compute-1.amazonaws.com