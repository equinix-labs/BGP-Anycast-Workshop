# Lab 07 - Adding an additional Anycast

## Goal

* Learn to modify Terraform
* Add an additional anycast IPv6 address

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab username (i.e. bgp03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Define the second Anycast address

The first (:1) IPv6 in the subnet is already in use so we'll create a second IPv6 address and use :2

```
vi ipv6.tf
```

Call the new address "anycast_addr_2" and assign it the second address in the subnet.

```
locals {
  # 8 bits is 2^8 or 256 labs
  anycast_network   = "${cidrsubnet(data.metal_precreated_ip_block.ipv6.cidr_notation,8,var.lab_number)}"
  anycast_addr      = "${cidrhost(local.anycast_network,1)}"
  anycast_addr_2    = "${cidrhost(local.anycast_network,2)}"
}
```

## Output the new Anycast address

The "output.tf" displays the generate values. Update it so that this new address is dislayed.

```
output "AnycastIPv6Address2" {
  value = local.anycast_addr_2
}
```

## Execute the Terraform Plan

Executing the Terraform plan will output the new Anycast address.

```
terraform plan
```

You should see the new address outputted similar to:

```
Anycast IPv6 Address 2 = 2604:1380:2:2303::2
```

Keep in mind that the new address hasn't be bound to the hosts.

## Next Steps

Once you've created the new address, proceed to [Lab 8](Lab08.md)
