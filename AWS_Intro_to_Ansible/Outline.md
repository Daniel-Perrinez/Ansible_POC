Title: “DevOps for SysOps (part 3): Introduction to Ansible”
-----------

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

Section 2: "What will we go over?"
-----------
 - Beginner, Intermediate, and Advanced uses cases of Ansible automation.

Section 3: "Beginner"
-----------
- 1st-beginner_playbook.yml
- Scenario: Configure system settings (e.g., timezone, hostname, user accounts)
    
Section 4: "Intermediate"
-----------
- 2nd-intermediate_playbook.yml
- Scenario: Deploy application to staging and production environments.
<!-- Check nginx -->
nginx -t
sudo systemctl restart nginx

ps aux | grep nginx



Section 5: "Advanced"
-----------
- 3rd-advanced_playbook.yml
- Scenario: Implement disaster recovery procedures, including automated failover and recovery testing
    - Configure NGINX & Gunicorn by manually writing the code first
    - Highlight using a RedHat pre-built module
    - Show event driven example?

