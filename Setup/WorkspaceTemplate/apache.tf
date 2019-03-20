
resource "null_resource" "apache" {

    depends_on = ["null_resource.configure_bird"]

    count = "${length(var.sites)}"

    connection {
        type = "ssh"
        host = "${element(packet_device.hosts.*.access_public_ipv4,count.index)}"
        private_key = "${file("mykey")}"
        agent = false
    }

    provisioner "remote-exec" {
        inline = [
            "apt-get -y update",
            "apt-get -y install apache2",
            "echo `hostname` > /var/www/html/index.html"
        ]
    }
}


