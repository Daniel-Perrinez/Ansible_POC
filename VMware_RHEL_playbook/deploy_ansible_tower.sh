# RHEL 8.4
sudo su -
sudo yum -y update
sudo yum -y install epel-release

#Configure nameservers 
sudo su -
vi /etc/resolv.conf 

# Create a line entry for each nameserver in your organization that this machine will use 
#       nameserver <ip address or hostname> 

Log out of the root user account 
Type the exit command, or Control-Z 

sudo yum install open-vm-tools-desktop