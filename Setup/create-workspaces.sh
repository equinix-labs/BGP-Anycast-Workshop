#!/bin/bash
#
#
# 
if [ "$#" -ne 2 ] ; then
  echo "Usage: $0 BGP-Password Number-Workspaces-To-Create" >&2
  exit 1
fi

BGP_PASSWORD="$1"
NUMBER_WORKSPACES="$2"

mkdir user01
cd user01
git clone https://github.com/packet-labs/Packet-BGP-LoadBalancing
cd Packet-BGP-LoadBalancing

cat > terraform.tfvars <<EOF
bgp_md5 = "$BGP_PASSWORD"
EOF

ssh-keygen -t ed25519 -f ./mykey  -q -N ""

terraform init

terraform apply -auto-approve

# check return code

terraform output > lab-details.txt



