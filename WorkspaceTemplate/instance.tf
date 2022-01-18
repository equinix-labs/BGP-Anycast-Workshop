resource "metal_ssh_key" "ssh-key" {
  name       = "mykey"
  public_key = file("mykey.pub")
}

# testing with IPv6
#resource "metal_reserved_ip_block" "elastic_ip" {
#  project_id = var.metal_project_id
#  type       = "public_ipv4"
#  quantity   = 1
#}

resource "metal_device" "hosts" {
  depends_on = [metal_ssh_key.ssh-key]

  hostname = format("%s-%s-%02d", var.lab_name, var.facility, count.index)

  plan             = "t1.small.x86"
  facilities       = [var.facility]
  operating_system = "ubuntu_18_04"
  billing_cycle    = "hourly"
  project_id       = var.metal_project_id
  count            = (var.instance_count)

  tags = [var.lab_name]

  connection {
    user        = "root"
    private_key = file("mykey")
  }
}
