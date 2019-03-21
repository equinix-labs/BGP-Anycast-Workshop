#!/bin/bash
#
# account running this script should have sudo group 
# 
if [ "$#" -ne 4 ] ; then
  echo "Usage: $0 BGP-Password Packet-Auth-Token Packet-Project-ID Number-Workspaces-To-Create" >&2
  exit 1
fi

#must be lower case since usernames must be lowercase
LAB_NAME="bgp"

BGP_PASSWORD="$1"
PACKET_AUTH_TOKEN="$2"
PACKET_PROJECT_ID="$3"
NUMBER_WORKSPACES="$4"

echo $NUMBER_WORKSPACES

for i in `seq -w 01 $NUMBER_WORKSPACES`
do
  # setup the new student account
  USER=$LAB_NAME$i
  echo "Creating $USER"
  #  encrypted password is openstack
  sudo useradd -d /home/$USER -p 42ZTHaRqaaYvI $USER 
  sudo mkdir /home/$USER
  sudo chown $USER.sudo /home/$USER
  sudo chmod 2775 /home/$USER


  echo ""                                       >  WorkspaceTemplate/terraform.tfvars
  echo bgp_md5 = \"$BGP_PASSWORD\"              >> WorkspaceTemplate/terraform.tfvars
  echo packet_auth_token=\"$PACKET_AUTH_TOKEN\" >> WorkspaceTemplate/terraform.tfvars
  echo packet_project_id=\"$PACKET_PROJECT_ID\" >> WorkspaceTemplate/terraform.tfvars


  # copy over the student files from the base template
  sudo -u $USER cp -r WorkspaceTemplate /home/$USER/
  pushd /home/$USER/WorkspaceTemplate
  sudo -u $USER ssh-keygen -t ed25519 -f /home/$USER/WorkspaceTemplate/mykey  -q -N ""
  sudo chmod g+w .
  sudo chmod g+r mykey*
  sudo -u $USER terraform init
  screen -dmS $USER-terraform-apply terraform apply -auto-approve | tee /home/$USER/terraform-apply.out ;
  popd
done
