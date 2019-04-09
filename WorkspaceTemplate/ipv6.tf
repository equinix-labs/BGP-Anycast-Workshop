data "packet_precreated_ip_block" "ipv6" {
  facility         = "ewr1"
  project_id       = "${var.packet_project_id}"
  address_family   = 6
  public           = true
}

locals {
  anycast_network   = "${cidrsubnet(data.packet_precreated_ip_block.ipv6.cidr_notation,8,2)}"
  anycast_addr      = "${cidrhost(local.anycast_network,1)}"
}
