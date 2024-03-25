**--- Workflow ---**
cd Ansible_POC/AWS_RHEL_Remote_Backend
terraform init -backend-config=vars/dp-sandbox/nonprod/backend.hcl
terraform plan -var-file vars/dp-sandbox/nonprod/vars.tfvars -backend-config=vars/dp-sandbox/nonprod/backend.hcl
terraform apply -var-file vars/dp-sandbox/nonprod/vars.tfvars -backend-config=vars/dp-sandbox/nonprod/backend.hcl -auto-approve




https://www.youtube.com/watch?v=1id6ERvfozo

0. Configure remote state
1. Deploy an EC2 instance for terraform.


