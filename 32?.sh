apt install isc-dhcp-server -y
sed -i 's/^INTERFACESv4=""/INTERFACESv4="eth1"/' /etc/default/isc-dhcp-server

sed -i 's/^INTERFACESv6=""/INTERFACESv6="eth1"/' /etc/default/isc-dhcp-server


echo "authoritative;
default-lease-time 600;
max-lease-time 7200;
ignore-client-updates;
ddns-update-style interim;
use-host-decl-names on;

subnet 172.16.0.0 netmask 255.255.255.0 {
  range 172.16.0.11 172.16.0.61;
  option routers 172.16.0.33;

  host hq-srv {
    hardware ethernet bc:24:11:87:df:fa;
    fixed-address 172.16.0.42;
  }
}" | tee /etc/dhcp/dhcpd.conf > /dev/null


echo "authoritative;
default-lease-time 600;
max-lease-time 7200;
ignore-client-updates;
ddns-update-style interim;
use-host-decl-names on;
allow leasequery;

subnet6 172:16:e::/124 {
  option dhcp6.preference 255;
  range6 172:16:e::2 172:16:e::3e;

  host hq-srv {
    #host-identifier option dhcp6.client-id 00:01:00:01:2d:68:b8:99:bc:24:11:ce:c2:cf;
    fixed-address6 172:16:e::a;
    fixed-prefix6 172:16:e::/124;
  }
}" | tee /etc/dhcp/dhcpd6.conf > /dev/null


systemctl restart isc-dhcp-server




echo "interface eth1
{
    AdvSendAdvert on;
    AdvManagedFlag on;
    AdvOtherConfigFlag on;

    prefix 172:16:e::/124 {
        AdvRouterAddr on;
    };
};" | tee /etc/radvd.conf > /dev/null


systemctl restart radvd && systemctl restart isc-dhcp-server


echo "route print -6"
