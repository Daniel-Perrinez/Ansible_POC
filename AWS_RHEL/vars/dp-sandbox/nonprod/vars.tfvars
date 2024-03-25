# dp-sandbox-NONPROD
#-----------------------
# .terraform.tfstate files are NOT checked into source code. To sync state import the backend resources with these commands.
# terraform init
# terraform import -var-file=vars/dp-sandbox/nonprod/vars.tfvars aws_s3_bucket.cx-terraform-state dp-sandbox-np-tf-resources-infrastructure-state
# terraform import -var-file=vars/dp-sandbox/nonprod/vars.tfvars aws_dynamodb_table.tf_state_lock tf-resources-infrastructure-state-lock
# terraform plan -var-file vars/dp-sandbox/nonprod/vars.tfvars -detailed-exitcode

environment                     = "NONPROD"
environment_prefix              = "dp-sandbox-np"
remote_state                    = "global/s3/terraform.tfstate"
terraform_state_bucket_name     = "rhel-remote-state-bucket"
dynamodb_table_name             = "rhel-remote-state-dynamodb-table"

tags = {
  Name = "dp-sandbox-np-rhel-remote-state"
  "Technical:ApplicationName"    = "RHEL POCs"
  "Technical:Environment"        = "NONPROD" #Variables may not be used here.
  "Technical:PlatformOwner"      = "daniel.perrinez@wei.com"
}

