


data "template_file" "enable_bgp" {
    template = "${file("templates/enable_bgp.tpl")}"
    vars = {
      anycast_ip       = "${local.anycast_addr}"
      anycast_network  = "${local.anycast_network}"
      bgp_password     = "${var.bgp_md5}"
    }
}

resource "null_resource" "configure_bird" {

    depends_on = ["null_resource.bird"]

    count = "${var.instance_count}"

    triggers = {
        template = "${data.template_file.enable_bgp.rendered}"
    }

    connection {
        type = "ssh"
        host = "${element(packet_device.hosts.*.access_public_ipv4,count.index)}"
        private_key = "${file("mykey")}"
        agent = false
    }

    provisioner "file" {
        content = "${data.template_file.enable_bgp.rendered}"
        destination = "/tmp/enable_bgp.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/enable_bgp.sh",
            "/tmp/enable_bgp.sh"
        ]
    }
}
