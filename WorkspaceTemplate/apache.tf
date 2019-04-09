
resource "null_resource" "apache" {

    depends_on = ["null_resource.bird"]

    count = "${var.instance_count}"

    connection {
        type = "ssh"
        host = "${element(packet_device.hosts.*.access_public_ipv4,count.index)}"
        private_key = "${file("mykey")}"
        agent = false
    }

    provisioner "remote-exec" {
        inline = [
            "apt-get -y update > apt-get-update-out.txt",
            "apt-get -y install apache2 > apt-get-apache2-out.txt",
            "echo `hostname` > /var/www/html/index.html",
        ]
    }
}


