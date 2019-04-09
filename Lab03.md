# Lab 03 - Examine IPv6 and BGP Settings

## Prerequisites

* Validate that anycast is running and load balancing across all servers from Lab 02

## Log into a Web Server via SSH

```
terraform output
ssh root@<server_1_ipv4> -i my_key
```
## Examine the v6 Addressing

Using the ip command, display the IPv6 addresses assigned to the host.
```
ip -6 a show
```

Sample output (your IPv6 addresses will differ):
```
root@bgp01-ewr1-00:~# ip -6 a show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
    inet6 2604:1380:2:2301::1/64 scope global deprecated
       valid_lft forever preferred_lft 0sec
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
4: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 2604:1380:2:2300::3/127 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::ec4:7aff:fee5:484c/64 scope link
       valid_lft forever preferred_lft forever
```

Take note of the ::1/64 address on the lo interface. That same address has been assigned to all the hosts in the cluster and communicated to the upstream router via BGP. It's the address used for the anycast failover.

The subnet assigned, :2301:, is assigned to this lab. The whole space 2604:1380:2:2301::/64 is available for your use as you wish. Only the ::1 address has been used so far.

The IPv6 address to the bond0 interface is a point to point link assigned to the host when it boots.

## Examine Network Interface File

## Examine BGP Data

Next we're going to examine the running BGP routing details using BIRD, an open source, software router.

Let's see what routing protocols are running. (Make sure to add the 6 to run the IPv6 version of birdc.)
```
birdc6 show protocols
```
You'll see that BGP is running.

Now examine the full BGP routing details.
```
birdc6 show protocols all bgp1
```

## Examine BIRD Configuration file

The BIRD software processes using a configuration file that details what routing protocols to run (BGP in our case)
```
more /etc/bird/bird6.conf
```

Take note of the "filter packet_bgp" and the network that is being communicated via BGP to the neighbor router. As you can see, this is the /64 that has been assigned to this lab.

## Next Steps

Once you've verified the BGP information proceed to [Lab 4](Lab04.md)
