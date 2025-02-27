Step 1: Connect to AWS
- 1. From: https://wei-eng.awsapps.com/start/#/?tab=accounts
    Grab the following values and paste them into your terminal:
    ```
    export AWS_ACCESS_KEY_ID="your_access_key"
    export AWS_SECRET_ACCESS_KEY="your_secret_key"
    export AWS_DEFAULT_REGION="your_preferred_region"
    ```
    // Create ssh key
    ```
    ssh-keygen -t rsa -b 4096
        /Users/danielperrinez/Desktop/WEI/Presentations/DevOps-for-SysOps/Ansible/Ansible_POC/creds/id_rsa
        123

    chmod 400 /Users/danielperrinez/Desktop/WEI/Presentations/DevOps-for-SysOps/Ansible/Ansible_POC/creds/id_rsa.pem

    ```

- 2. Setup Terraform environment
    ```
    cd ./AWS_Intro_to_Ansible/beginner/TF
    terraform init
    terraform plan
    terraform apply

    //test ssh connection
    ping 44.211.30.96
    ssh -i ../../../creds/id_rsa ec2-user@44.211.30.96
    ```

- 3. Startup and Deploy Ansible playbook
    ```
    cd Ansible_POC/AWS_Intro_to_Ansible/beginner/Ansible

    //Verify your inventory.
    ansible-inventory -i inventory.yml --list

    //Run your playbook
    ansible-playbook test-connectivity_playbook.yml -i inventory.yml
    ansible-playbook 1st-beginner_playbook.yml -i inventory.yml
    ```

- 4. Advanced section only
Add the following to your ansible.cfg, `ansible --version` will tell you where ansible.cfg is.
`nano ~/.ansible/plugins/modules/ansible.cfg`

```
[galaxy]
server_list = automation_hub, release_galaxy

[galaxy_server.automation_hub]
url=https://console.redhat.com/api/automation-hub/content/validated/
auth_url=https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token
token=<Your_Automation_Hub_Token>

[galaxy_server.release_galaxy]
url=https://galaxy.ansible.com/
```

Test connection
`ansible-galaxy collection list -s automation_hub`

Install the collectiions
```
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install community.aws

ansible-galaxy collection install cloud.aws_ops
```

TF needs
```
- RDS cluster and instances. (postgres free tier)
    pw: 12345678
- A Bastion host.
- SSH key pair to connect to the host.
    pw: 123
```

```
ansible-galaxy init test_role

ansible-playbook -i inventory/inventory.yml 3rd-advanced_import_roles_playbook.yml 
```