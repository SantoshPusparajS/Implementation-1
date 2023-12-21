#!/bin/bash
cd /home/azureuser/scripts
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_SSH_ARGS="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get clean
sudo apt-get update
sleep 10
ansible-playbook -i db_inventory mysql-config.yml --private-key=/home/azureuser/.ssh/terraform-azure.pem --user=azureuser
sleep 10
ansible-playbook -i php_inventory httpd-config.yml --private-key=/home/azureuser/.ssh/terraform-azure.pem --user=azureuser