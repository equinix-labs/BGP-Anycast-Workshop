# OS specific setup 
# configuring the operating system as per the OSA target hosts prepare guide as per:
# https://docs.openstack.org/project-deploy-guide/openstack-ansible/rocky/targethosts-prepare.html
# this script is intended to be called by Terraform

apt-get update
apt-get install -y bridge-utils debootstrap ifenslave ifenslave-2.6 \
  lsof chrony sudo tcpdump vlan python
echo '8021q' >> /etc/modules-load.d/openstack-ansible.conf

# openstack - for console login
usermod --password Ym1Sx4Sc8lvEw root
