
resource "metal_ssh_key" "default" {
  depends_on = ["tls_private_key.default"]
  name       = "default"
  public_key = tls_private_key.default.public_key_openssh
}

resource "metal_device" "lab-master" {

  depends_on = ["metal_ssh_key.default"]

  hostname         = var.hostname
  operating_system = var.operating_system
  plan             = var.instance_type

  connection {
    user        = "root"
    private_key = tls_private_key.default.private_key_pem
    agent       = false
    timeout     = "30s"
  }
  facilities    = ["${var.metal_facility}"]
  project_id    = var.metal_project_id
  billing_cycle = "hourly"

  provisioner "file" {
    source      = "${var.operating_system}.sh"
    destination = "os-setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "ssh-keygen -A",
      "bash os-setup.sh > os-setup.out",
    ]
  }
}
