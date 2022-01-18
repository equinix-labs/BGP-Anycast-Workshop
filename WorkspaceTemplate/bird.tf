
resource "null_resource" "bird" {

  depends_on = ["metal_device.hosts"]

  count = var.instance_count

  connection {
    type        = "ssh"
    host        = element(metal_device.hosts.*.access_public_ipv4, count.index)
    private_key = file("mykey")
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get -y update > apt-get-update-out.txt",
      "apt-get -y install bird > apt-get-bird-out.txt 2> apt-get-gird-err.txt",
      "sysctl net.ipv4.ip_forward=1",
      "sysctl net.ipv6.conf.all.forwarding=1",
    ]
  }
}


