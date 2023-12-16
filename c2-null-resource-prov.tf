resource "null_resource" "configurations" {
  count = length(resource.azurerm_linux_virtual_machine.ansible-demo[*].public_ip_address)
  connection {
    type        = "ssh"
    user        = "azureuser"
    private_key = file("./ssh-key/terraform-azure.pem")
    host        = resource.azurerm_linux_virtual_machine.ansible-demo[count.index].public_ip_address
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
    source      = "./ssh-key/"
    destination = "/home/azureuser/.ssh"
    when        = create
  }

  provisioner "local-exec" {
    command = "del E:\\Terraform\\Implementation-1\\Terraform\\application.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/azureuser/scripts",
      "sudo sh scripts.sh",
      "sleep 10",
      "ansible-playbook application-config.yml",
    ]
  }

  provisioner "local-exec" {
    command = "echo http://${resource.azurerm_linux_virtual_machine.ansible-demo[count.index].public_ip_address}/phpinfo.php >> application.txt"
  }

}
