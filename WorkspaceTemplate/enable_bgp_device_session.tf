
resource "null_resource" "enable_bgp_device_session" {

  count = var.instance_count

  provisioner "local-exec" {
    command = "curl -X POST -H \"X-Auth-Token: ${var.metal_auth_token}\" https://api.equinix.com/metal/v1/devices/${element(metal_device.hosts.*.id, count.index)}/bgp/sessions?address_family=ipv6"
  }
}
