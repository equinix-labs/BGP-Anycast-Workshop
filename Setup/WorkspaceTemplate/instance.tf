resource "packet_ssh_key" "ssh-key" {
  name       = "mykey"
  public_key = "${file("mykey.pub")}"
}

resource "packet_reserved_ip_block" "elastic_ip" {
  project_id = "${var.packet_project_id}"
  type       = "global_ipv4"
  quantity   = 1
}

resource "packet_device" "hosts" {
  depends_on = ["packet_ssh_key.ssh-key"]

  hostname = "${format("%s-%02d", var.sites[count.index], 1)}"
  plan             = "t1.small.x86"
  facilities       = [ "${var.sites[count.index]}" ]
  operating_system = "ubuntu_18_04"
  billing_cycle    = "hourly"
  project_id       = "${var.packet_project_id}"
  count            = "${length(var.sites)}"

  connection {
    user        = "root"
    private_key = "${file("mykey")}"
  }
}
