
resource "null_resource" "lab-users" {

  depends_on    = ["null_resource.lab-software"]

  connection {
    user        = "root"
    private_key = "${tls_private_key.default.private_key_pem}"
    host        = "${packet_device.lab-master.access_public_ipv4}"
    agent       = false
    timeout     = "30s"
  }

  # create-workspaces.sh BGP-Password Packet-Auth-Token Packet-Project-ID Number-Workspaces-To-Create" >&2
  provisioner "file" {
    source      = "create-workspaces.sh"
    destination = "create-workspaces.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash create-workspaces.sh ${var.bgp_password} ${var.packet_auth_token} ${var.packet_project_id} ${var.number_labs} > create-workspaces.out",
    ]
  }

}
