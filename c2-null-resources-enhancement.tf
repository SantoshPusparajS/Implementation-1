resource "null_resource" "controller" {
  count = length(resource.azurerm_linux_virtual_machine.ansible-demo[*].public_ip_address)
  #connection block to do actions on the remote host
  connection {
    type        = "ssh"
    user        = "azureuser"
    private_key = file("./ssh-key/terraform-azure.pem")
    host        = resource.azurerm_linux_virtual_machine.ansible-demo[0].public_ip_address
  }
  triggers = {
    always_run = timestamp()
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/azureuser",
      "sudo mkdir -p scripts",
      "sudo chmod -R 777 scripts",
      "cd /home/azureuser/.ssh",
      "rm -rf terraform-*"
    ]
  }

  provisioner "file" {
    source      = "Ansible/"
    destination = "/home/azureuser/scripts"
  }

  provisioner "file" {
    source      = "shell-scripts/"
    destination = "/home/azureuser/scripts"
  }

  provisioner "file" {
    source      = "./ssh-key/"
    destination = "/home/azureuser/.ssh"
    when        = create
  }

  provisioner "local-exec" {
    command = "del E:\\Terraform\\Implementation-1-V1.0\\Terraform\\application.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/azureuser/scripts",
      "sudo sh scripts.sh",
      "sleep 10",
      "sudo sh scp-scripts.sh ${join(" ",
        slice(azurerm_network_interface.ansible_network_interf[*].private_ip_address, 1, length(azurerm_network_interface.ansible_network_interf[*].private_ip_address))
      )}",
      "echo ${azurerm_network_interface.ansible_network_interf[count.index].private_ip_address} >> ${count.index > 0 ? (count.index % 2 == 1 ? "db_inventory" : "php_inventory") : "/dev/null"}",
      "sudo sh run-ansible-playbook.sh"
    ]
  }

  provisioner "local-exec" {
    command    = "echo http://${azurerm_linux_virtual_machine.ansible-demo[count.index].public_ip_address}/phpinfo.php >> ${count.index > 0 ? (count.index % 2 == 1 ? "" : "application.txt") : ""}"
    on_failure = continue
  }

}
