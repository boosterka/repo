systemctl restart frr
systemctl enable --now frr
vtysh << EOF
conf t
router ospf
network 192.168.0.0/26 area 0
network 172.28.14.0/24 area 0
exit
do wr
conf t
router ospf6
ospf6 router-id 1.1.1.100
exit
interface gre1
ipv6 ospf6 area 0
exit
interface eth1
ipv6 ospf6 area 0
exit
do wr
EOF