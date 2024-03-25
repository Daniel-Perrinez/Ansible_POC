## AWS_RHEL_Remote_Backend
We need to setup a remote backend so that we can manage IaC more easiliy with a centralized TF state file.
Note that only the tfstate file for the backend itself needs to be checked into source control.

**--- Workflow ---**
aws sso login --profile Daniel-Perrinez-Sandbox --region us-east-1
cd Ansible_POC/AWS_RHEL_Remote_Backend
terraform init
terraform plan -var-file ../AWS_RHEL/vars/dp-sandbox/nonprod/vars.tfvars
terraform apply -var-file ../AWS_RHEL/vars/dp-sandbox/nonprod/vars.tfvars -auto-approve