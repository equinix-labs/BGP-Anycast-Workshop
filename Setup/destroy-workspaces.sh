#!/bin/bash
#
#
# 
cd user01
cd Packet-BGP-LoadBalancing

terraform destroy -auto-approve
cd ../..
rm -rf user01

