
data "template_file" "enable_anycast_1" {
  template = file("templates/enable_anycast_1.tpl")
  vars = {
    anycast_ip_1 = local.anycast_addr_1
  }
}

resource "null_resource" "enable_anycast_1" {

  depends_on = [null_resource.bird]

  count = var.instance_count

  triggers = {
    template = data.template_file.enable_anycast_1.rendered
  }

  connection {
    type        = "ssh"
    host        = element(metal_device.hosts.*.access_public_ipv4, count.index)
    private_key = file("mykey")
    agent       = false
  }

  provisioner "file" {
    content     = data.template_file.enable_anycast_1.rendered
    destination = "/tmp/enable_anycast_1.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/enable_anycast_1.sh",
      "/tmp/enable_anycast_1.sh"
    ]
  }
}
