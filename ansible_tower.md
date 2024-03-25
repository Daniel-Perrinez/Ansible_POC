
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