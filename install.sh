#!/bin/bash


read_mysql_pass () {
    read -p 'Set New mysql root password: ' MYSQL_ROOT_PASS
    read -p 're-enter mysql root password: ' MYSQL_ROOT_PASS1
}

read_BENCH_NAME() {
    read -p 'Name of the bench: ' BENCH_NAME
}

read_production_mode() {
    read -p 'Do you want to setup bench on production (y/n): ' PRODUCTION_MODE
}

read_ENABLE_SWAP() {
    read -p 'Do you want to Enable SWAP 4GB (y/n): ' ENABLE_SWAP
}

read_mysql_pass


if [  $MYSQL_ROOT_PASS =  $MYSQL_ROOT_PASS1 ]
then
   echo "mysql root password is set"
else
    echo "password dont match"
    read_mysql_pass
fi
echo "=============================================="
echo ""
read_BENCH_NAME
echo "=============================================="
echo ""
if [ -z "$BENCH_NAME" ]
then
    echo "Directory name cant be Empty $BENCH_NAME"
    read_BENCH_NAME
else
    echo "Bench directory will be $BENCH_NAME"
fi
echo "=============================================="
echo ""
read_production_mode
echo "=============================================="
echo ""
if [  $PRODUCTION_MODE =  'y' ]
then
    echo "Will set bench on production"
    PRODUCTION_MODE='1'
elif [  $PRODUCTION_MODE =  'n' ]
then
    echo "Bench will be setup as dev mode"
    PRODUCTION_MODE='0'
else
    echo "please give ans in y or n"
    read_production_mode
fi

read_ENABLE_SWAP
echo "=============================================="
echo ""
if [  $ENABLE_SWAP =  'y' ]
then
    echo "Will enable swap 4GB"
    ENABLE_SWAP='1'
elif [  $ENABLE_SWAP =  'n' ]
then
    echo "will NOT setup swap"
    ENABLE_SWAP='0'
else
    echo "please give ans in y or n"
    read_ENABLE_SWAP
fi

apt update -y
apt install python3-pip python3-setuptools git cowsay file -y
pip3 install --upgrade pip
python3 -m easy_install --upgrade pyOpenSSL
pip3 install ansible redis
git clone https://github.com/sahilk25/bloomstack_provision.git
cd bloomstack_provision
cowsay -f tux starting ansible script~
ansible-playbook bench.yaml -vv -e mysql_root_pass=$MYSQL_ROOT_PASS -e bench_name=$BENCH_NAME -e production_mode=$PRODUCTION_MODE -e enable_swap=$ENABLE_SWAP
