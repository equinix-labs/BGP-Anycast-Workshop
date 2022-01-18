
# set via environment variable TF_VAR_metal_project_id
variable "metal_project_id" {
  description = "Equinix Metal Project ID"
}

# set via environment variable TF_VAR_metal_auth_token
variable "metal_auth_token" {
  description = "Equinix Metal API Token"
}

variable "hostname" {
  description = "Lab hostname"
  default     = "anycast-lab-master"
}

variable "metal_facility" {
  description = "Equinix Metal facility. Default: ewr1"
  default     = "ewr1"
}

variable "instance_type" {
  description = "Instance type of OpenStack compute nodes"
  default     = "c1.small.x86"
}

variable "operating_system" {
  description = "Operating System to install across nodes"
  default     = "ubuntu_18_04"
}

variable "bgp_password" {
  description = "BGP password configured with Equinix Metal upstream router"
  default     = "ExamplePassword1234"
}

variable "number_labs" {
  description = "Number of labs to create"
  default     = "3"
}
