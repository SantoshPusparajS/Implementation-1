#!/bin/sh
cd /home/azureuser/.ssh
# Check if at least one argument is provided
if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <private_ip_1> <private_ip_2> ... <private_ip_n>"
  exit 1
fi

# Iterate through the provided private IPs
for private_ip in "$@"; do
  echo $private_ip
  # Perform scp command to copy files to each VM
  scp -o StrictHostKeyChecking=no -i /home/azureuser/.ssh/terraform-azure.pem authorized_keys azureuser@${private_ip}:/home/azureuser/.ssh
done