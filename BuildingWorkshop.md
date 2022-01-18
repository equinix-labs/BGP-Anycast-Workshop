## Overview

These instructions walk through setting up an environment to support multiple students attending this workshop. It is fully self contained and will spin up all the student environments so they can dive right into things without having to install supporting tools and software.

If you're looking to run this workshop just for yourself, feel free to set the number_labs (See below) to 1. This will spin up just a single student environment.

If you're looking to run this at a public event (conference, meetup, etc), drop Equinix Metal a note and they might hook you up with credits to run the lab.

## Setup the environment

Clone this repo someplace where Terraform is available. To install Terraform, please see [Terraform Download](https://www.terraform.io/downloads.html)

```
git clone https://github.com/equinix-labs/BGP-Anycast-Workshop
```

## Define the Lab Settings

The default values are appropriate for most installations.

```
cd BGP-Anycast-Workshop/
cd Labmaster/
cp terraform.tfvars.sample terraform.tfvars
```

## Setup your Equinix Metal Credentials

Replace with your Equinix Metal project ID and user API key (don't use a Project API key). Make sure the values are contained in paramethesis.

```
echo metal_auth_token=\"ABCDEFGHIJKLMNOPQRSTUVWXYZ123456\" >> terraform.tfvars
echo metal_project_id=\"12345678-90AB-CDEF-GHIJ-KLMNOPQRSTUV\" >> terraform.tfvars
```

By default, 3 labs will be spun up (with 2 hosts per lab). This can be changed with the variable number_labs.

## Deploy the Lab Master

The Lab Master is used by students to run Terraform and as a jump host to the deployed hosts. It will be setup with the required tools (Git and Terraform) for the students to use.

Execute this Terraform to build the lab master. It will create the user accounts on the lab master (bgp01, bpg02, bpg03,...) and run Terraform within each user accounts.

```
terraform apply
```

A default password is set for the lab accounts and password logins via SSH are enabled. Please see "create-workspace.sh" for the details.

## Verify Access

Students can log into the Lab Master via SSH and the password login. Each student can then follow the Lab instructions in this repo.

## Clean up

Make sure that students tear down their labs via "terraform destroy" or destroy then via the Equinix Metal GUI. Running "terraform destroy" in the LabMaster only destroys the Lab Master host and not the student hosts.
