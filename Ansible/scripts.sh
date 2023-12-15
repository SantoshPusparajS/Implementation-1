#!/bin/sh
sudo apt-get update
sudo apt-get install ansible -y
cd /home/azureuser/.ssh
ls -lrt
cat terraform-azure.pub >> authorized_keys
chmod 600 authorized_keys
chmod 400 terraform-azure.pem