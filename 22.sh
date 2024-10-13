sed -i 's/^ospfd=no/ospfd=yes/g' /etc/frr/daemons

systemctl restart frr


systemctl enable --now frr


vtysh << EOF
conf t
router ospf
network 172.16.0.32/28 area 0
network 172.28.14.0/24 area 0
exit
do wr
router ospf6
ospf6 router-id 2.2.2.100
exit
int gre1
ipv6 ospf6 area 0
exit
int eth1
ipv6 ospf6 area 0
exit
do wr
exit
exit
EOF
