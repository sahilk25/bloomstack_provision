apt install python3-pip -y
python3 -m easy_install --upgrade pyOpenSSL
pip3 install ansible
pip3 install redis
git clone https://github.com/sahilk25/bloomstack_provision.git
cd bloomstack_provision
ansible-playbook bench.yaml -vv
