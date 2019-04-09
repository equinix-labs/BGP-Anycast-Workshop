#!/bin/bash
#
# this file writes the bird configuration file for IPv6 and
# setups up the (shared) anycast address on the host

# these values are filled in by Terraform as a template
ANYCAST_IP=${anycast_ip}
ANYCAST_NETWORK=${anycast_network}
BGP_PASSWORD=${bgp_password}

# these values are pulled from the local networking configuration
PRIVATE_ADDRESS=$(hostname -I | awk '{print $2}')
GATEWAY=$(ip -6 route | awk '/default/ { print $3 }')


mv /etc/bird/bird6.conf  /etc/bird/bird6.conf.orig

cat << EOF >> /etc/bird/bird6.conf
filter packet_bgp {
    if net = $ANYCAST_NETWORK then accept;
}
router id $PRIVATE_ADDRESS;
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
    neighbor $GATEWAY as 65530;
    password "$BGP_PASSWORD";
}
EOF

# append to the interfaces file
cat << EOF >> /etc/network/interfaces

auto lo:0
iface lo:0 inet6 static
   address ${anycast_ip}
   netmask 64
EOF

ifup lo:0
service bird6 restart
