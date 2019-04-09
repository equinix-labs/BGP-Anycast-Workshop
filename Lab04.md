# Lab 04 - Examine Webserver & BGP Config Generation

## Goals

* Understand how the configuration files are generated

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab username (i.e. bgp03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Examine Web Terraform Config

Let's take a look how the webserver is configured to display the hostname. 

```
cd WorkspaceTemplate/
more apache.tf
```

Very simply, apache, a web server is installed, and the default webpage (index.html) is written out to simply contain the hostname of the host.

## Generating the IPv6 Subnets

The setting of the IPv6 anycast address is a little more complex but straight forward. Let's take a look at the Terraform configuration that handles the network allocation.

```
more ipv6.tf
```

The ```cidrsubnet``` Terraform command is the 

```
anycast_network   = "${cidrsubnet(data.packet_precreated_ip_block.ipv6.cidr_notation,8,var.lab_number)}"
```
The "packet_precreated_ip_block" is the IPv6 block that has been assigned to this project. The ```cidrsubnet``` Terraform command then takes the large IPv6 block and splits it out into 2^8 subnets (the 8 represents the number of additional subnet bits).

This results in 256 subnets available across all the labs. Using the lab number, one of the individual subnets it then assigned to the lab.

```
anycast_addr      = "${cidrhost(local.anycast_network,1)}"
```
Within this subnet, the first (1) IP address is then assigned as the anycast address used for across all the hosts.

## Configuring the host networking via Terraform

Using a Terraform template file, the networking information is used to update a template which is then run on the host. This sets up the IPv6 networking and BIRD BGP configuration file.

```
more templates/enable_bgp.tpl
```

The last few lines show how the network interfaces file is appended with the anycast IPv6 address.


## Examine BGP Terraform Config

BIRD, the BGP software router, is installed using Terraform in bird.tf.
```
more bird.tf
```

The IPv6 networking and BIRD template file is configured via ```configure_bird.tf```. This Terraform file defines all of the variables that are used in the template.

```
more configure_bird.tf
```

## Next Steps

Once you feel comfortable on how Terraform is used to configure the IPv6 and BGP routing, proceed to [Lab 5](Lab05.md)
