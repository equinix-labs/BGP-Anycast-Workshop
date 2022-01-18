# Lab 08 - Adding an additional Anycast

## Goal

* Master the Terraform and auto configure the hosts with the new Anycast address

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab username (i.e. bgp03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Create the new Anycast address

Edit ```ipv6.tf``` and create a new variable called ```anycast_addr_2``` that uses the ::2 address in the IPv6 subnet.

```
  anycast_addr_1      = "${cidrhost(local.anycast_network,1)}"
  anycast_addr_2      = "${cidrhost(local.anycast_network,2)}"
```

## Configure the new Anycast on the hosts

We'll need a new template that will apply the new address to the host. This new file would be "templates/enable_anycast_2.tpl". You can copy "templates/enable_anycast_1.tpl" as a base and edit.

```
cp templates/enable_anycast_1.tpl templates/enable_anycast_2.tpl
vi templates/enable_anycast_2.tpl
```

It should look like:

```
auto lo:1
iface lo:1 inet6 static
   address ${anycast_ip_2}
   netmask 64
EOF

ifup lo:1
service bird6 restart
```

## Define the template variables

We'll need new Terraform files that will define the variables and execute the template on the host. Simple use the existing files for the first anycast address and modify the variables within to use the ::2 address.

```
cp enable_anycast_1.tf enable_anycast_2.tf
vi enable_anycast_2.tf
```

It should look like:

```
data "template_file" "enable_anycast_2" {
    template = "${file("templates/enable_anycast_2.tpl")}"
    vars = {
      anycast_ip_2     = local.anycast_addr_2
    }
}

resource "null_resource" "enable_anycast_2" {

    depends_on = [null_resource.bird]

    count = var.instance_count

    triggers = {
        template = data.template_file.enable_anycast_2.rendered
    }

    connection {
        type = "ssh"
        host = "${element(metal_device.hosts.*.access_public_ipv4,count.index)}"
        private_key = "${file("mykey")}"
        agent = false
    }

    provisioner "file" {
        content = data.template_file.enable_anycast_2.rendered
        destination = "/tmp/enable_anycast_2.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/enable_anycast_2.sh",
            "/tmp/enable_anycast_2.sh"
        ]
    }
}
```

## Plan and Apply Terraform

Review and execute the Terraform.

```
terraform plan  | more
terraform apply --auto-approve
```

## Verify the new Anycast address

The new Anycast address should respond to curl requests.

```
curl http://[Anycast IPv6 Address 2]/
```

## Verify the IPv6 Networking

Log into the deployed host and examine the networking.

```
terraform output
ssh root@<Server IP 4> -i mykey
ip -6 a show
```

Check that the new IPv6 Anycast address (::2) is assigned.

## Next Steps

Once you're confident that the new address is working, proceed to [Lab 9](Lab09.md)
