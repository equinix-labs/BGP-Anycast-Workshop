output "Server IPs" {
  value = "${packet_device.hosts.*.access_public_ipv4}"
}

output "Elastic IP" {
  value = "${packet_reserved_ip_block.elastic_ip.cidr_notation}"
}
