#!/bin/bash
#
#
# 

LAB_NAME="bgp"

for i in `seq -w 01 60`
do
  USER=$LAB_NAME$i
  echo "Deleting $USER"
  cd /home/$USER/WorkspaceTemplate/
  terraform destroy -auto-approve
  sudo userdel -f $USER
  sudo rm -rf /home/$USER
done
