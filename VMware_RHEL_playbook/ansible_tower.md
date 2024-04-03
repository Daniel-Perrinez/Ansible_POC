**--- VMWare Setup ---**
0. Deploy RHEL_9.3 instance
1. Check what version of ansible you are running:
```
ansible --version
ansible [core 2.16.2]
  config file = None
  configured module search path = ['/Users/danielperrinez/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/homebrew/Cellar/ansible/9.1.0/libexec/lib/python3.12/site-packages/ansible
  ansible collection location = /Users/danielperrinez/.ansible/collections:/usr/share/ansible/collections
  executable location = /opt/homebrew/bin/ansible
  python version = 3.12.1 (main, Dec  7 2023, 20:45:44) [Clang 15.0.0 (clang-1500.0.40.1)] (/opt/homebrew/Cellar/ansible/9.1.0/libexec/bin/python)
  jinja version = 3.1.3
  libyaml = True
```

**--- Ansible Workflow ---**
cd Ansible_POC/VMware_RHEL_playbook
ansible-playbook -i inventory.yaml ansible_tower_install.yaml --limit VMWare_RHEL_9_3 -vvvv

# [Ansible Automation Platform Quick Installation Guide v3.8.6](https://docs.ansible.com/ansible-tower/latest/html/quickinstall/index.html)

---

## To deploy Ansible Tower on RHEL 8.4, you can follow these steps:

### Update System and Add EPEL Repository:
Update your RHEL 8.4 system and add the EPEL repository.
`
    sudo yum -y update
    sudo yum -y install epel-release
`

### Install Ansible and Other Dependencies:
Install Ansible and other necessary dependencies.
`
    sudo yum -y install ansible vim curl
`

### Download Ansible Tower Archive:
Download the latest Ansible Tower release.
`
    mkdir /tmp/tower && cd /tmp/tower
    curl -k -O https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz
    tar xvf ansible-tower-setup-latest.tar.gz
`

### Install Ansible Tower:
Navigate to the created directory and edit the inventory file to set required credentials.
`
    cd ansible-tower-setup*/
    vim inventory
`

Configure the necessary variables in the inventory file like admin password, database details, etc.
Start the installation of Ansible Tower on RHEL 8.4.
`
    sudo ./setup.sh
`

### Configure Ansible Tower:
Access the Web UI using a browser by pointing to your Ansible Tower server IP or hostname via HTTPS.
Log in as an admin user with the password set in the inventory file.
Configure the license, browse to the license file, accept terms, and finish the installation.