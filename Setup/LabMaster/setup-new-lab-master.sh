apt-get update
apt-get install git -y
apt-get install unzip -y

touch /var/lib/cloud/instance/warnings/.skip

vi /etc/ssh/sshd_config

service sshd restart


https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
unzip terraform_0.11.13_linux_amd64.zip
mv terraform /usr/local/bin/
rm terraform_0.11.13_linux_amd64.zip


