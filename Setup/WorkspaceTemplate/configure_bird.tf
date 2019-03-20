
data "template_file" "enable_bgp" {
    template = "${file("templates/enable_bgp.tpl")}"
    vars = {
      cidr_notation      = "${packet_reserved_ip_block.elastic_ip.cidr_notation}"
      floating_ip       = "${packet_reserved_ip_block.elastic_ip.address}"
#      floating_cidr     = "${packet_reserved_ip_block.elastic_ip.cidr}"
      floating_netmask  = "${packet_reserved_ip_block.elastic_ip.netmask}"
#      private_ipv4      = "${element(packet_device.hosts.*.access_private_ipv4,count.index)}"
      bgp_password      = "${var.bgp_md5}"
    }
}

resource "null_resource" "configure_bird" {

    count = "${length(var.sites)}"

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
