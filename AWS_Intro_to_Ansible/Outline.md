Title: “DevOps for SysOps (part 3): Introduction to Ansible”
-----------

---------------------------------------------------------------------------
Section 0: "What will we go over?"
-----------
 1. What is Ansible, 
 2. The Structure of Ansible
 3. Beginner
 4. Intermediate
 5. Advanced uses cases of Ansible automation.

---------------------------------------------------------------------------
Section 1: "What is Ansible, what is it good for?"
-----------
 - Ansible is an open-source automation tool developed by Red Hat that simplifies complex IT tasks.
 - Key features of Ansible:
    - You can use it almost anywhere - Windows, Mac, Linux, and more!
    - Agentless: Ansible uses SSH to execute commands remotely against almost any target, irregardless of OS (Win, Linux, Mac, ect.).
        - Use it manage not only OSs but hardware like routers and switches!
    - Declarative scripting language: Users describe the desired state of systems, and Ansible determines how to achieve it.
    - Idempotence: Applying the same configuration multiple times yields identical results, preventing configuration drift.
    - Extensibility: Ansible supports custom modules and plugins for integration with existing infrastructure.
    - Scalability: Ansible can manage thousands of machines, making it suitable for both small and large-scale environments


---------------------------------------------------------------------------
Section 2: "The Structure of Ansible"
-----------
It uses no agents and no additional custom security infrastructure, so it is easy to deploy - and most importantly, it uses a very simple language (YAML, in the form of Ansible Playbooks) that allows you to describe your automation jobs in a way that approaches plain English.


In this section, we’ll give you a really quick overview of how Ansible works so you can see how the pieces fit together.
- Modules: 
    Ansible works by connecting to your nodes and pushing out scripts called “Ansible modules” to them. Most modules accept parameters that describe the desired state of the system. Ansible then executes these modules (over SSH by default), and removes them when finished. Your library of modules can reside on any machine, and there are no servers, daemons, or databases required.

- Module utilities:
    When multiple modules use the same code, Ansible stores those functions as module utilities to minimize duplication and maintenance. For example, the code that parses URLs is lib/ansible/module_utils/url.py. You can write your own module utilities as well. Module utilities may only be written in Python or in PowerShell.

- Plugins:
    Plugins augment Ansible’s core functionality. While modules execute on the target system in separate processes (usually that means on a remote system), plugins execute on the control node within the /usr/bin/ansible process. Plugins offer options and extensions for the core features of Ansible - transforming data, logging output, connecting to inventory, and more. Ansible ships with a number of handy plugins, and you can easily write your own. For example, you can write an inventory plugin to connect to any datasource that returns JSON. Plugins must be written in Python.

- Inventory: https://docs.ansible.com/ansible/latest/dev_guide/overview_architecture.html#inventory
    By default, Ansible represents the machines it manages in a file (INI, YAML, and so on) that puts all of your managed machines in groups of your own choosing.
    ...
    If there’s another source of truth in your infrastructure, Ansible can also connect to that. Ansible can draw inventory, group, and variable information from sources like EC2, Rackspace, OpenStack, and more.

    Once inventory hosts are listed, variables can be assigned to them in simple text files (in a subdirectory called ‘group_vars/’ or ‘host_vars/’) or directly in the inventory file.

    Or, as already mentioned, use a dynamic inventory to pull your inventory from data sources like EC2, Rackspace, or OpenStack.

- Playbooks: https://docs.ansible.com/ansible/latest/dev_guide/overview_architecture.html#playbooks
    Playbooks can finely orchestrate multiple slices of your infrastructure topology, with very detailed control over how many machines to tackle at a time. This is where Ansible starts to get most interesting.

    Ansible’s approach to orchestration is one of finely-tuned simplicity, as we believe your automation code should make perfect sense to you years down the road and there should be very little to remember about special syntax or features.


- The Ansible search path: https://docs.ansible.com/ansible/latest/dev_guide/overview_architecture.html#the-ansible-search-path
    Modules, module utilities, plugins, playbooks, and roles can live in multiple locations. If you write your own code to extend Ansible’s core features, you may have multiple files with similar or the same names in different locations on your Ansible control node. The search path determines which of these files Ansible will discover and use on any given playbook run.



---------------------------------------------------------------------------
Section 3: "Use cases for Ansible - Beginner"
-----------
- 1st-beginner_playbook.yml
- Scenario: Configure system settings (e.g., timezone, hostname, user accounts)
 - Create a file named inventory.yml in your Ansible directory.
 - Add a user on a linux system

---------------------------------------------------------------------------
Section 4: "Use cases for Ansible - Intermediate"
-----------
- 2nd-intermediate_playbook.yml
- Scenario: Deploy application to staging and production environments.
<!-- Check nginx -->
nginx -t
sudo systemctl restart nginx

ps aux | grep nginx


 - Install and configure a web server on multiple Linux machines.
 - Configuring the web server with basic settings
 - Ensuring the service is running

---------------------------------------------------------------------------
Section 5: "Use cases for Ansible - Advanced"
-----------
- https://github.com/redhat-cop/cloud.aws_ops/tree/main/roles/deploy_flask_app
- 3rd-advanced_playbook.yml
- Scenario: Implement disaster recovery procedures, including automated failover and recovery testing
    - Configure NGINX & Gunicorn by manually writing the code first
    - Highlight using a RedHat pre-built module
    - Show event driven example?

