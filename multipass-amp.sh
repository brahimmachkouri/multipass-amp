#!/bin/bash
# the vm name is the filename
vmname=$(basename $0)

# get the vm ip and put it in inventory.yml
ip=$(multipass list | grep $vmname | awk '{ printf "%s",$3}')
if [ -z "$ip" ]
then
	echo "no ip found for $vmname"
	exit 1
fi
sed 's/{{ hostip }}/'$ip'/' inventory > inventory.yml

# use the multipass private key to use the multipass vm
user=$(whoami)
sudo cp /var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa ./mp_private_key
sudo chown $user ./mp_private_key

# install apache2, mysql and php
ansible-playbook -i inventory.yml playbook.yml

# install codeigniter
mkdir -p ./localhost
multipass mount ./localhost $vmname:/var/www/localhost
multipass exec $vmname -- composer create-project CodeIgniter/framework /var/www/localhost
multipass exec $vmname -- chmod -R 777 /var/www/localhost

# Go !
echo "Go to http://$ip"

