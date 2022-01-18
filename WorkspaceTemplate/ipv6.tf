data "metal_precreated_ip_block" "ipv6" {
  facility       = var.facility
  project_id     = var.metal_project_id
  address_family = 6
  public         = true
}

locals {
  # 8 bits is 2^8 or 256 labs
  anycast_network = cidrsubnet(data.metal_precreated_ip_block.ipv6.cidr_notation, 8, var.lab_number)
  anycast_addr_1  = cidrhost(local.anycast_network, 1)
}
