# Lab 07 - Automatically Deploy a Web Server with BGP Enabled

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab number, log into the lab master server using the your assigned lab and password.

```
ssh <your_lab>@labs.packetlabs.tech
```

## Increase the Web Server Count

```
vi vars.tf 
```

## Plan and Apply Terraform

```
terraform plan
terraform apply
```

## Verify BGP Routing

Log into the new web server
```
terraform output
ssh root@<new_webserver_ip> -i default.pem
```

Verify that the BGP data is correct.
```
bird ...
```


## Verify new Web Server is in Anycast

```
terraform output
curl http://<anycast_ip>
curl http://<anycast_ip>
```
Repeat curl until the new web server name appears.

## Next Steps

Once you've brought the new Web Server online, proceed to Lab 8