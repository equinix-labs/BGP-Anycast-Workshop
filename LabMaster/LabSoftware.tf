
resource "null_resource" "lab-software" {

  depends_on = ["metal_device.lab-master"]

  connection {
    user        = "root"
    private_key = tls_private_key.default.private_key_pem
    host        = metal_device.lab-master.access_public_ipv4
    agent       = false
    timeout     = "30s"
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install git unzip -y",
      "wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip",
      "unzip terraform_0.11.13_linux_amd64.zip",
      "mv terraform /usr/local/bin",
      "rm terraform_0.11.13_linux_amd64.zip",
    ]
  }
}
