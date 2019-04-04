# Lab 03 - Validate BGP Settings

## Prerequisites

* Validate that anycast is running and load balancing across all servers from Lab 02

## Log into a Web Server via SSH

```
terraform output
ssh root@<web01_ip> - default.pem
```

## View BGP Data

```
bird ...
```

## View BIRD Configuration file

```
cat /etc/bird/...
```

## Next Steps

Once you've verified the BGP information proceed to Lab 4