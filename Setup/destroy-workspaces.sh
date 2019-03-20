#!/bin/bash
#
#
# 

LAB_NAME="bgp"

for i in `seq -w 01 60`
do
  USER=$LAB_NAME$i
  echo "Deleting $USER"
  sudo userdel -f $USER
  sudo rm -rf /home/$USER
done
