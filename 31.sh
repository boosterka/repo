sed -i 's/^INTERFACESv4=""/INTERFACESv4="eth1"/' /etc/default/isc-dhcp-server

sed -i 's/^INTERFACESv6=""/INTERFACESv6="eth1"/' /etc/default/isc-dhcp-server


echo "authoritative;
default-lease-time 600;
max-lease-time 7200;
ignore-client-updates;
ddns-update-style interim;
use-host-decl-names on;

subnet 192.168.0.0 netmask 255.255.255.192 {
  range 192.168.0.11 192.168.0.61;
  option routers 192.168.0.1;

  host hq-srv {
    hardware ethernet !!INPUT MAC!!;
    fixed-address 192.168.0.60;
  }
}" | sudo tee /etc/dhcp/dhcpd.conf > /dev/null


echo "authoritative;
default-lease-time 600;
max-lease-time 7200;
ignore-client-updates;
ddns-update-style interim;
use-host-decl-names on;
allow leasequery;

subnet6 192:168:d::/122 {
  option dhcp6.preference 255;
  range6 192:168:d::2 192:168:d::3e;

  host hq-srv {
    host-identifier option dhcp6.client-id \"!!CLIENT-ID!!\";
    fixed-address6 192:168:d::6;
    fixed-prefix6 192:168:d::/122;
  }
}" | sudo tee /etc/dhcp/dhcpd6.conf > /dev/null
