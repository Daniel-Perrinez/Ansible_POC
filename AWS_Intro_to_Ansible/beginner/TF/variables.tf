variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


# # No variables allowed for (subnet_id, ami, vpc_security_group_ids)
# variable "environment_configurations" {
#   type = map(object({
#     instance_type          = string
#     ami                    = string
#     subnet_id              = string
#     vpc_security_group_ids = list(string)
#     count                  = number
#     tags                   = map(string)
#   }))
#   default = {
#     dev = {
#       instance_type          = "t2.micro"
#       ami                    = "ami-06b21ccaeff8cd686"
#       subnet_id              = "subnet-0364889d16613f3eb"
#       vpc_security_group_ids = ["sg-0c4d97543f7a0d47d"]
#       count                  = 3
#       tags = {
#         Environment = "Development"
#       }
#     }
#     test = {
#       instance_type          = "t2.nano"
#       ami                    = "ami-06b21ccaeff8cd686"
#       subnet_id              = "subnet-0364889d16613f3eb"
#       vpc_security_group_ids = ["sg-0c4d97543f7a0d47d"]
#       count                  = 3
#       tags = {
#         Environment = "Testing"
#       }
#     }
#     prod = {
#       instance_type          = "t2.small"
#       ami                    = "ami-06b21ccaeff8cd686"
#       subnet_id              = "subnet-0364889d16613f3eb"
#       vpc_security_group_ids = ["sg-0c4d97543f7a0d47d"]
#       count                  = 3
#       tags = {
#         Environment = "Production"
#       }
#     }
#   }
# }


variable "project" {
  description = "Project name"
  type        = string
  default     = "WEI-Intro-to-Ansible"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "WEI-DevOps-Team"
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    "Company" = "WEI"
    "Team"    = "WEI_DevOps"
  }
}

variable "resource_specific_tags" {
  description = "Additional tags to be merged with common tags"
  type        = map(string)
  default = {
    "IaC_Files" = "Ansible_POC/AWS_Intro_to_Ansible/beginner/TF" #TODO: would like to make this a dynamic value based on the file which defines the resource.
  }
}

locals {
  tags = merge(
    var.common_tags,
    var.resource_specific_tags,
    {
      Environment = "development"
      Project     = var.project
      Owner       = var.owner
    }
  )
}