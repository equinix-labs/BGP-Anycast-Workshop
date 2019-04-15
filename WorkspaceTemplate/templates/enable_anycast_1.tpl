# append to the interfaces file
cat << EOF >> /etc/network/interfaces

auto lo:0
iface lo:0 inet6 static
   address ${anycast_ip}
   netmask 64
EOF

ifup lo:0
service bird6 restart
