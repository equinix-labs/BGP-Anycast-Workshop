
This workshop is designed to be sell contained and will deploy all the infrastructure you need to run your own lab. You will need an account on Packet



## Setup the environment

```
git clone https://github.com/packet-labs/BGP-Anycast-Workshop
```

## Setup the Labmaster

The Lab Master is used by students to run Terraform and as a jump host to the deployed hosts. 

```
cd BGP-Anycast-Workshop/
cd Labmaster/
cp terraform.tfvars.sample terraform.tfvars
```

## Setup your Packet Credentials

Replace with your Packet project ID and user API key (don't use a Project API key). Make sure the values are contained in paramethesis.

```
echo packet_auth_token=\"ABCDEFGHIJKLMNOPQRSTUVWXYZ123456\" >> terraform.tfvars
echo packet_project_id=\"12345678-90AB-CDEF-GHIJ-KLMNOPQRSTUV\" >> terraform.tfvars
```

By default, 3 labs will be spun up (with 2 hosts per lab). This can be changed with the variable number_labs. 

## Deploy the Lab Master

Execute this Terraform to build the lab master. It will create the user accounts on the lab master (bgp01, bpg02, bpg03,...) and run Terraform within each user accounts.

```
terraform apply
```

A default password is set for the lab accounts and password logins via SSH are enabled. Please see "create-workspace.sh" for the details.

## Verify Access

Students can log into the Lab Master via SSH and the password login. Each student can then follow the Lab instructions in this repo.

## Clean up

Make sure that students tear down their labs via "terraform destroy" or destroy then via the Packet GUI. Running "terraform destroy" in the LabMaster only destroys the Lab Master host and not the student hosts.