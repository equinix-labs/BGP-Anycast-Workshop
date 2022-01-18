#!/bin/bash
#
# account running this script should have sudo group 
# 
if [ "$#" -ne 5 ] ; then
  echo "Usage: $0 BGP-Password Metal-Auth-Token Metal-Project-ID Number-Workspaces-To-Create Facility" >&2
  exit 1
fi

#must be lower case since usernames must be lowercase
LAB_NAME="bgp"

BGP_PASSWORD="$1"
METAL_AUTH_TOKEN="$2"
METAL_PROJECT_ID="$3"
NUMBER_WORKSPACES="$4"
FACILITY="$5"

echo BGP_PASSWORD=$BGP_PASSWORD
echo METAL_AUTH_TOKEN=$METAL_AUTH_TOKEN
echo METAL_PROJECT_ID=$METAL_PROJECT_ID
echo NUMBER_WORKSPACES=$NUMBER_WORKSPACES
echo FACILITY=$FACILITY

rm -rf BGP-Anycast-Workshop/
git clone https://github.com/equinix-labs/BGP-Anycast-Workshop
cd BGP-Anycast-Workshop/

# Terraform needs access to these to install plugins
chmod 755 ~root
touch ~root/.netrc
chmod 777 ~root/.netrc

for i in `seq -w 01 $NUMBER_WORKSPACES`
do
  # setup the new student account
  USER=$LAB_NAME$i
  echo "Creating $USER"
  #  encrypted password is openstack
  sudo useradd -d /home/$USER -p 42ZTHaRqaaYvI -s /bin/bash $USER 
  sudo mkdir /home/$USER
  sudo chown $USER.sudo /home/$USER
  sudo chmod 2775 /home/$USER


  echo ""                                       >  WorkspaceTemplate/terraform.tfvars
  echo bgp_md5 = \"$BGP_PASSWORD\"              >> WorkspaceTemplate/terraform.tfvars
  echo metal_auth_token=\"$METAL_AUTH_TOKEN\" >> WorkspaceTemplate/terraform.tfvars
  echo metal_project_id=\"$METAL_PROJECT_ID\" >> WorkspaceTemplate/terraform.tfvars
  echo lab_number=\"$i\"                        >> WorkspaceTemplate/terraform.tfvars
  echo lab_name=\"$USER\"                       >> WorkspaceTemplate/terraform.tfvars
  echo facility=\"$FACILITY\"            >> WorkspaceTemplate/terraform.tfvars


  # copy over the student files from the base template
  sudo -u $USER cp -r WorkspaceTemplate /home/$USER/
  pushd /home/$USER/WorkspaceTemplate
  sudo -u $USER ssh-keygen -t ed25519 -f /home/$USER/.ssh/id_ed25519  -q -N ""
  sudo -u $USER cp /home/$USER/.ssh/id_ed25519 /home/$USER/WorkspaceTemplate/mykey
  sudo -u $USER cp /home/$USER/.ssh/id_ed25519.pub /home/$USER/WorkspaceTemplate/mykey.pub
  sudo chmod g+w .
  sudo chmod 400 /home/$USER/.ssh/id_ed25519
  sudo touch terraform.tfstate
  sudo chown $USER.sudo terraform.tfstate
  sudo -u $USER terraform init
  screen -dmS $USER-terraform-apply terraform apply -auto-approve
  popd
  # pause to prevent overloading deployments
  sleep 20
done

cat <<EOF >> /etc/ssh/sshd_config
Match user $LAB_NAME*
  PasswordAuthentication yes
EOF
service sshd restart
