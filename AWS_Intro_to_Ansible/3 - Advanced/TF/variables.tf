variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

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
      Project     = var.project
      Owner       = var.owner
    }
  )
}