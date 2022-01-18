# Lab 05 - Growing the cluster

## Goals

* Understand how to grow the cluster to include additional hosts that are automatically assigned to the anycast and have traffic balanced across.

## Prerequisites

* Access to the lab master server from Lab 01

## Lab Master Access

With your assigned lab username (i.e. bgp03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Increate the host count

The number of hosts is defined in the Terraform variables configuration file ```vars.tf```. Increase it from the current count of 2 to 3.

```
cd WorkspaceTemplate/
vi vars.tf
```

The sample below already has the count increased to 3.
```
# number of hosts to deploy
variable "instance_count" {
    default = "3"
}
```
## Examine Terraform Plan

Before applying this change to the network, let's examine what Terraform is planning to do. Items marked as [2] refer to our third instance which is to be deployed. Instances [0] and [1] have already been deployed.
```
terraform plan | more
```

In brief, Terraform will be:
  * metal_device.hosts[2] - deploying the bare metal host [2]
  * apache[2] - configuring apache on host [2]
  * bird[2] - installing BIRD on host [2]
  * configure_bird[2] - configuring BIRD on host [2]
  * enable_bgp_device_session[2] - notifying the upstream router that host [2] is an active BGP neighbor

## Execute the Terraform Plan

Confident that Terraform will be doing the right thing, go ahead and apply the Terraform plan.

```
terraform apply --auto-approve
```


It'll take a approximately 3 minutes for the bare metal host to come online and then a few more minutes for the software installation.

## Validate the new Host and Anycast

Terraform will now report back three hosts and the new host will be broadcasting BGP to the upstream router. Let's verify it is all functioning correctly.

```
terraform output
curl http://<Server IP v4 #1>
curl http://<Server IP v4 #2>
curl http://<Server IP v4 #3>
```

Now test the anycast address and validate that the new server is in the rotation. It might take a minute for BGP to sync and it to appear.
```
curl http://[Anycast IPv6 Address]
```

Repeat the ```curl``` command until you see the new web server show up.


In our sample below, the new server (02) it appeared on the second curl.
```
bgp03@stl:~/WorkspaceTemplate$  curl http://[2604:1380:2:2303::1]
bgp03-ewr1-00
bgp03@stl:~/WorkspaceTemplate$  curl http://[2604:1380:2:2303::1]
bgp03-ewr1-02
bgp03@stl:~/WorkspaceTemplate$  curl http://[2604:1380:2:2303::1]
bgp03-ewr1-01
```

## Next Steps

Once you've validate that the bonus server is functioning and part of the anycast, proceed to [Lab 6](Lab06.md)
