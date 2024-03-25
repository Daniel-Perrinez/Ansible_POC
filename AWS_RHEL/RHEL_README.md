**--- Workflow ---**
cd Ansible_POC/AWS_RHEL
terraform init -backend-config=vars/dp-sandbox/nonprod/backend.hcl
terraform plan -var-file vars/dp-sandbox/nonprod/vars.tfvars
terraform apply -var-file vars/dp-sandbox/nonprod/vars.tfvars -auto-approve



### What is Ansible | Ansible Playbook explained | Ansible Tutorial for Beginners
https://www.youtube.com/watch?v=1id6ERvfozo

0. Configure remote state
1. Deploy an EC2 instance for terraform.


