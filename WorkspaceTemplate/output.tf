output "ServerIPv4s" {
  value = metal_device.hosts.*.access_public_ipv4
}

output "ServerIPv6s" {
  value = metal_device.hosts.*.access_public_ipv6
}

output "AnycastIPv6Address" {
  value = local.anycast_addr_1
}

output "AnycastIPv6Network" {
  value = local.anycast_network
}

output "IPv6AnycastCurlCommand" {
  value = "curl http://[${local.anycast_addr_1}]"
}

output "SSHAccessServer0" {
  value = "ssh root@${metal_device.hosts.0.access_public_ipv4} -i mykey"
}
