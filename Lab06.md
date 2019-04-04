# Lab 06 - Release the Bonus Web Server

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab number, log into the lab master server using the your assigned lab and password.

```
ssh <your_lab>@labs.packetlabs.tech
```

## Remove the Bonus Web Server from Terraform

This will deallocate the hardware and remove it from your lab.

```
mv bonus-webserver.tf bonus-webserver.tf-off
```

## Plan and Apply Terraform

```
terraform plan
terraform apply
```

## Next Steps

Once you've released the hardware, proceed to Lab 7.