variable "metal_auth_token" {}

variable "metal_project_id" {}

variable "bgp_md5" {}

variable "lab_number" {}

variable "lab_name" {}

variable "facility" {
  default = "ewr1"
}

# number of hosts to deploy
variable "instance_count" {
  default = "2"
}

