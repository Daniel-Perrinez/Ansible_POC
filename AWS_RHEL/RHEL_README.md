**--- Terraform Workflow ---**
cd Ansible_POC/AWS_RHEL
terraform init -backend-config=vars/dp-sandbox/nonprod/backend.hcl
terraform plan -var-file vars/dp-sandbox/nonprod/vars.tfvars
terraform apply -var-file vars/dp-sandbox/nonprod/vars.tfvars -auto-approve

**--- Ansible Workflow ---**
cd Ansible_POC/VMware_RHEL_playbook
ansible-playbook -i inventory.yaml ansible_tower_install.yaml --limit VMWare_RHEL_8_4



### What is Ansible | Ansible Playbook explained | Ansible Tutorial for Beginners
https://www.youtube.com/watch?v=1id6ERvfozo

0. Configure remote state
1. Deploy an EC2 instance for terraform.


### SSH
chmod 400 "pem/rhel.pem"
ssh -i "pem/rhel.pem" ec2-user@10.123.1.69