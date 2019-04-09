# Lab 06 - Shrinking the Network

## Goals

* Examine how to shrink the network

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab username (i.e. bgp03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Decreate the host count

The number of hosts is defined in the Terraform variables configuration file ```vars.tf```. Decreate it from the current count to 1.

```
cd WorkspaceTemplate/
vi vars.tf
```

The sample below already has the count decreased to 1.
```
# number of hosts to deploy
variable "instance_count" {
    default = "1"
}
```
## Examine Terraform Plan

Before applying this change to the network, let's examine what Terraform is planning to do. Most notably, we see that the physical hosts are going to be released/destroyed.
```
terraform plan | more
```

## Execute the Terraform Plan

Confident that Terraform will be doing the right thing, go ahead and apply the Terraform plan.

```
terraform apply --auto-approve
```

Destroying hosts is fast and Terraform will complete quickly.

## Validate the new Host and Anycast

Terraform will now report back a single hosts. Let's verify it is all functioning correctly.

```
terraform output
curl http://<Server IP v4 #1>
```

Now test the anycast address to make sure that just the single host is returned.
```
curl http://[Anycast IPv6 Address]
```

Repeat the ```curl``` command to see that just the single remaining host is returned.

## Next Steps

Once you've released the hardware, proceed to [Lab 7](Lab07.md)
