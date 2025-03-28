Directory layout: https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#directory-layout

inventories/
   production/
      hosts               # inventory file for production servers
      group_vars/
         group1.yml       # here we assign variables to particular groups
         group2.yml
      host_vars/
         hostname1.yml    # here we assign variables to particular systems
         hostname2.yml

   staging/
      hosts               # inventory file for staging environment
      group_vars/
         group1.yml       # here we assign variables to particular groups
         group2.yml
      host_vars/
         stagehost1.yml   # here we assign variables to particular systems
         stagehost2.yml


Setting up a Dynamic Inventory for AWS: https://docs.ansible.com/ansible/2.8/user_guide/intro_dynamic_inventory.html#inventory-script-example-aws-ec2
<!-- you may need to unset envars -->
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_REGION
unset AWS_OUTPUT

aws sso login --profile my-profile

aws ec2 describe-instances \
    --instance-ids i-090afcd31269f4345

ansible-inventory -i inventories/aws_ec2.yml --list
ansible-inventory -i inventories/aws_ec2.yml --graph




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
    <!-- # ssh forwarding ... no need to use ssh password -->
    eval $(ssh-agent)
    ssh-add ../../../creds/id_rsa

    cd Ansible_POC/AWS_Intro_to_Ansible/beginner/Ansible

    //Verify your inventory.
    ansible-inventory -i inventory.yml --list

    //Run your playbook
    ansible-playbook test-connectivity_playbook.yml -i inventory.yml
    ansible-playbook 1st-beginner_playbook.yml -i inventory.yml
    ```


- 4. Advanced Flask Deployment
Playbooks --> Roles --> Tasks
https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html

<!-- Verify roles location -->
ansible-galaxy role list 
https://developers.redhat.com/articles/2023/08/17/how-deploy-flask-application-python-gunicorn#the_application

cd Ansible_POC/AWS_Intro_to_Ansible/3-Advanced/Flask_app

DEV --> python flask_app.py
PROD --> 
sudo podman build -t flask_pod:1.0.0 .
sudo podman run -it --rm -p 80:80 flask_pod:1.0.0
sudo gunicorn --config gunicorn_config.py --bind 0.0.0.0:80 flask_app:app

curl 0.0.0.0:80/
curl 34.229.132.203:80/



ps aux | grep python3

- 4. (Validated Solution ... work in progress) Advanced section only
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
pipx install ansible-rulebook ansible ansible-runner

ansible-galaxy collection install amazon.aws
ansible-galaxy collection install amazon.cloud
ansible-galaxy collection install community.aws
ansible-galaxy collection install cloud.aws_ops
ansible-galaxy collection install community.libvirt
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
-- Testing prior to launch
aws sts get-caller-identity
ansible-galaxy init test_role
aws ec2 describe-instances --instance-ids i-0aef57f5686c1c80b

ansible-playbook -i inventory/inventory.yml 3rd-advanced_import_roles_playbook.yml 
```


Live Demo:
```
cd /Users/danielperrinez/Desktop/WEI/Presentations/DevOps-for-SysOps/Part 3 - Ansible/Ansible_POC/AWS_Intro_to_Ansible/3-Advanced/Ansible

aws sso login --profile Daniel-Perrinez-Sandbox
```
<!-- Update and deploy dev app -->
update: 
    3-Advanced/Flask_app/templates/index_dev.html
    3-Advanced/Flask_app/static/css/dev.css

run:
```
ansible-inventory -i inventories/development/aws_ec2.yml --graph
git add .
git commit -a -m "updated dev site"
git push origin main
ansible-playbook -i inventories/development/aws_ec2.yml --extra-vars "@inventories/development/host_vars/dev.yml" 3rd-advanced_roles_playbook.yml
```

<!-- Update and deploy prod app -->
update: 
    3-Advanced/Flask_app/templates/index_prod.html
    3-Advanced/Flask_app/static/css/prod.css

run:
```
ansible-inventory -i inventories/production/aws_ec2.yml --graph
git add .
git commit -a -m "updated prod site"
git push origin main


ansible-playbook 3rd-advanced_roles_playbook.yml \
    -i inventories/production/aws_ec2.yml \
    --extra-vars "@inventories/production/host_vars/prod.yml" 

```

troubleshooting:
```
ssh -i creds/id_rsa ec2-user@ec2-3-227-240-148.compute-1.amazonaws.com
```