output "Lab IP" {
  value = "${packet_device.lab-master.access_public_ipv4}"
}
