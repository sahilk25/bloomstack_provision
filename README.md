# bloomstack_provision
This script contain setup for bloomstack (fappe+erpnext+bloomstack_core) env from scratch.  

### Vsersions
Ansible: 4.6.0  
Python: 3.6.5  
Mariadb: 10.4.23  

### Prerequisites:  
Fresh ubuntu 18.04 or 20.04 server with root privileges.  

Main file for this script is: install.sh  
which will ask for some basic information and then run the main ansible command.  
info like this:  
mysql root password  
bench name  
setup mysql and redis in docker or not  
setup bench in production or not  
enable swap  

### default setup values are:  
user: frappe  
mute_emails: true  
swap_size: 4GB  

### This will setup:
- frappe 
- frappe-bench #install via pip3
- Mariadb #install via mariadb official repo
- Redis
- Python
- Install Apps
    - erpnext
    - bloomstack_core
    - frappe
- docker # if you want to setup docker
- oh-my-zsh
- bs command
- Firewall
    - Enable Firewall*(22,80,443)
    - Add custom config for SSH
    - Enable Firewall for docker #if setup yes
- custom .vimrc
- swap

## [![YourActionName Actions Status](https://github.com/{userName}/{repoName}/workflows/{workflowName}/badge.svg)](https://github.com/sahilk25/bloomstack_provision/actions)
**this is for ubuntu 18.04 & 20.04**
```
sudo su
wget https://raw.githubusercontent.com/sahilk25/bloomstack_provision/staging/install.sh
chmod +x install.sh
bash install.sh
```
