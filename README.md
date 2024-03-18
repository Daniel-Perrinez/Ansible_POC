# Ansible_POC
Testing and showing off Ansible
## Ansible Core Concepts
Terraform is for provisioning servers (and other infrastructure),
Ansible is for configuring servers.

## Ansible Control Station

## Ansible Install (Mac)
*As of 1/10/24*
**Install Steps**
`
brew update 
brew install ansible
ansible --version
    ansible [core 2.16.2]
      config file = None
      configured module search path = ['/Users/danielperrinez/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
      ansible python module location = /opt/homebrew/Cellar/ansible/9.1.0/libexec/lib/python3.12/site-packages/ansible
      ansible collection location = /Users/danielperrinez/.ansible/collections:/usr/share/ansible/collections
      executable location = /opt/homebrew/bin/ansible
      python version = 3.12.1 (main, Dec  7 2023, 20:45:44) [Clang 15.0.0 (clang-1500.0.40.1)] (/opt/homebrew/Cellar/ansible/9.1.0/libexec/bin/python)
      jinja version = 3.1.2
  libyaml = True
`

## Ansible Essential Files
- ansible.cfg
    <!-- try this for testing -->
    host_key_checking=false

- hosts

## Ansible Configuration as Code
Automations are organized in:
 - Playbooks (YAML)
    - Plays
        - Tasks

## YAML
YAML == YAML Aint Markup Language
" --- " at the top of a file denotes yaml 


## POC
To run the playbook poc you simply run the following from your ansible control station:
`
ansible-playbook ansible_playbook_poc.yaml
`