sed -i 's/^INTERFACESv4=""/INTERFACESv4="eth1"/' /etc/default/isc-dhcp-server

sed -i 's/^INTERFACESv6=""/INTERFACESv6="eth1"/' /etc/default/isc-dhcp-server
