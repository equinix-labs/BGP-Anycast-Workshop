# Lab 02 - Verifying Anycast

## Prerequisites

* Access to the lab master server from Lab 01
* Validate that all web server instances are running OK from Lab 01

## Verify Individual Web Servers

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