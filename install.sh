#!/bin/bash


read_mysql_pass () {
    read -p 'Set New mysql root password: ' mysql_root_pass
    read -p 're-enter mysql root password: ' mysql_root_pass1
}
read_mysql_pass

if [  $mysql_root_pass =  $mysql_root_pass1 ]
then
   echo "mysql root password is set"
else
    echo "password dont match"
    read_mysql_pass
fi
apt update -y
apt install python3-pip -y
python3 -m easy_install --upgrade pyOpenSSL
pip3 install ansible redis
git clone https://github.com/sahilk25/bloomstack_provision.git
cd bloomstack_provision
ansible-playbook bench.yaml -vv -e mysql_root_pass=$mysql_root_pass
