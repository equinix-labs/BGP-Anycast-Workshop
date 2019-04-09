# Lab 06 - Manually enable BGP to Bonus Web Server

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab number, log into the lab master server using the your assigned lab and password.

```
ssh <your_lab>@labs.packetlabs.tech
```

## Bonus Web Server details

Take note of the IP address of the "bonus" web server you've been assigned. It is up and running but has not been configured to run BGP or assigned to the anycast address.

```
terraform output
curl http://<bonus_web_ip>/
```

## Setup BIRD Configuration


## Validate Anycast

Run

```
terraform output
curl http://<anycast_ip>
curl http://<anycast_ip>
```
Repeat the ```curl``` command until you see the new "bonus" web server show up.

## Next Steps

Once you've validate that the bonus server is functioning and part of the anycast, proceed to [Lab 6](Lab06.md)
