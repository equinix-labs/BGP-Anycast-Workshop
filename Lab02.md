# Lab 02 - Verifying Anycast

## Prerequisites

* Access to the lab master server from Lab 01
* Validate that all web server instances are running OK from Lab 01

## Overview

Each of the deployed hosts is running a web server that simply returns back the hostname. We're going to validate that the web server on each is running and returning a different hostname. We're then going to check the load balancing using the anycast address to show that traffic is distributed across all the hosts.

## Verify Individual Web Servers

Each host running a web server that returns back it's hostname. Let's verify that each host web server is running correctly and that the correct hostname is being returned.

### Get the list of hosts again
```
terraform output
```
### Verify IPv4 
```
curl http://<Server IP v4 #1> 
curl http://<Server IP v4 #2>
```

Our sample output below shows the output from the web server as "bgp03-ewr1-00". The hostname consists of the lab number (bgp03), data center (ewr01), and host instance (00). Each lab initially has two host instances (00 and 01).
```
bgp03@stl:~/WorkspaceTemplate$ curl http://147.75.98.155/
bgp03-ewr1-00
```

Let's do the same check with IPv6. Make sure to use the square brackets around the IPv6 address.

```
curl http://[<Server IPs v6 #1>]
curl http://[<Server IPs v6 #2>]
```

## Verify Anycast Capabilities

We've verified that each individual server is running so now validate that a traffic is split across all hosts using the anycast address. Repeat the command several times to validate that traffic is split across all the hosts.

```
terraform output
curl http://[Anycast IPv6 Address]/
curl http://[Anycast IPv6 Address]/
curl http://[Anycast IPv6 Address]/
```

In this sample output, traffic ends up at host bgp03-ewr1-00 and bgp03-ewr1-01.

```
bgp03@stl:~/WorkspaceTemplate$ curl http://[2604:1380:2:2303::1]
bgp03-ewr1-00
bgp03@stl:~/WorkspaceTemplate$ curl http://[2604:1380:2:2303::1]
bgp03-ewr1-01
bgp03@stl:~/WorkspaceTemplate$ curl http://[2604:1380:2:2303::1]
bgp03-ewr1-01
```

## Next Steps

Once you're done and have verified that Anycast load balancing is working, proceed to [Lab 3](Lab03.md)
