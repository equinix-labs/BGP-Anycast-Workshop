#!/bin/bash

json=$(curl https://metadata.packet.net/metadata)
private_address=$(echo $json | jq -r ".network.addresses[] | select(.public == false) | .address")
gateway=$(echo $json | jq -r ".network.addresses[] | select(.public == false) | .gateway")

apt-get install -y bird
mv /etc/bird/bird.conf  /etc/bird/bird.conf.orig

cat << EOF >> /etc/bird/bird.conf
filter packet_bgp {
    if net = ${cidr_notation} then accept;
}
router id $private_address;
protocol direct {
    interface "lo";
}
protocol kernel {
    scan time 10;
    persist;
    import all;
    export all;
}
protocol device {
    scan time 10;
}
protocol bgp {
    export filter packet_bgp;
    local as 65000;
    neighbor $gateway as 65530;
    password "${bgp_password}";
}
EOF

# append to the interfaces file
cat << EOF >> /etc/network/interfaces

auto lo:0
iface lo:0 inet static
   address ${floating_ip}
   netmask ${floating_netmask}
EOF

sysctl net.ipv4.ip_forward=1
ifup lo:0
service bird restart

