sed -i 's/^INTERFACESv4=""/INTERFACESv4="eth0"/' /etc/default/isc-dhcp-server

sed -i 's/^INTERFACESv6=""/INTERFACESv6=""/' /etc/default/isc-dhcp-server
