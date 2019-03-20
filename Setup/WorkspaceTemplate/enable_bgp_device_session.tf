
resource "null_resource" "enable_bgp_device_session" {

    count = "${length(var.sites)}"

    provisioner "local-exec" {
        command = "curl -X POST -H \"X-Auth-Token: ${var.packet_auth_token}\" https://api.packet.net/devices/${element(packet_device.hosts.*.id,count.index)}/bgp/sessions?address_family=ipv4"
    }
}
