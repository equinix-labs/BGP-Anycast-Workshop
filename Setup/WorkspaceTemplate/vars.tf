variable "packet_auth_token" {}

variable "packet_project_id" {}

variable "bgp_md5" {}

variable "lab_number" {}

# sites that currently support global_ip4 - AMS1, EWR1, NRT1, and SJC1 

# there will be one server provisioned at each location in this list
# if you want more than one server at a data center, just list it multiple times in the list
variable "sites" {
    default = [ "ewr1", "nrt1" ]
}

