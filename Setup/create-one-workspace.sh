#!/bin/bash
#
#
# 
if [ "$#" -ne 2 ] ; then
  echo "Usage: $0 BGP-Password username" >&2
  exit 1
fi

BGP_PASSWORD="$1"
USERNAME="$2"

mkdir $USERNAME
cp -r WorkspaceTemplate/* $USERNAME/
cd $USERNAME

cat > terraform.tfvars <<EOF
bgp_md5 = "$BGP_PASSWORD"
EOF

ssh-keygen -t ed25519 -f ./mykey  -q -N ""

terraform init

terraform apply -auto-approve

# check return code

terraform output > lab-details.txt



