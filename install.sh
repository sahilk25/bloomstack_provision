#!/bin/bash


read_mysql_pass () {
    read -p 'Set New mysql root password: ' mysql_root_pass
    read -p 're-enter mysql root password: ' mysql_root_pass1
}

read_bench_name() {
    read -p 'Name of the bench: ' bench_name
}

read_production_mode() {
    read -p 'Do you want to setup bench on production (y/n): ' production_mode
}
read_mysql_pass


if [  $mysql_root_pass =  $mysql_root_pass1 ]
then
   echo "mysql root password is set"
else
    echo "password dont match"
    read_mysql_pass
fi

read_bench_name

if [ -z "$bench_name" ]
then
    echo "Directory name cant be Empty $bench_name"
    read_bench_name
else
    echo "Bench directory will be $bench_name"
fi

read_production_mode
if [  $production_mode =  'y' ]
then
    echo "Will set bench on production"
    production_mode = '1'
elif [  $production_mode =  'n' ]
then
    echo "Bench will be setup as dev mode"
    production_mode = '0'
else
    echo "please give ans in y or n"
    read_production_mode
fi

apt update -y
apt install python3-pip git -y
python3 -m easy_install --upgrade pyOpenSSL
pip3 install ansible redis
git clone https://github.com/sahilk25/bloomstack_provision.git
cd bloomstack_provision
ansible-playbook bench.yaml -vv -e mysql_root_pass=$mysql_root_pass -e bench_name=$bench_name -e production_mode=$production_mode
