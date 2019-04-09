
# set via environment variable TF_VAR_packet_project_id
variable "packet_project_id" {
  description = "Packet Project ID"
}

# set via environment variable TF_VAR_packet_auth_token
variable "packet_auth_token" {
  description = "Packet API Token"
}

variable "hostname" {
  description = "Lab hostname"
  default = "anycast-lab-master"
}

variable "packet_facility" {
  description = "Packet facility. Default: ewr1"
  default = "ewr1"
}

variable "instance_type" {
  description = "Instance type of OpenStack compute nodes"
  default = "c1.small.x86"
}

variable "operating_system" {
  description = "Operating System to install across nodes"
  default = "ubuntu_18_04"
}

variable "bgp_password" {
  description = "BGP password configured with Packet upstream router"
  default = "ExamplePassword1234"
}

variable "number_labs" {
  description = "Number of labs to create"
  default = "3"
}
