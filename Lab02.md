# Lab 02 - Verifying Anycast

## Prerequisites

* Access to the lab master server from Lab 01
* Validate that all web server instances are running OK from Lab 01

## Verify Individual Web Servers

Each host running a web server that returns back it's hostname. Let's verify that each host web server is running correctly and that the correct hostname is being returned.

### Get the list of hosts again
```
terraform output
```
### Verify IPv4 
```
curl http://<web_host_1_ipv4> 
curl http://<web_host_2_ipv4>
```

Let's do the same check with IPv6. Make sure to use the square brackets.

```
curl http://[<web_host_1_ipv6>]
curl http://[<web_host_2_ipv6>]
```

## Verify Anycast Capabilities

ssh root@<web_ip_number> -i default.pem
```

```
terraform output
curl http://web01_ip/
curl http://web02_ip/
```

## Verify Anycast 

```
terraform output
curl http://<anycast_ip>/
curl http://<anycast_ip>/
curl http://<anycast_ip>/
```



## Next Steps

Once you're done and have verified that Anycast load balancing is working, proceed to Lab 3
