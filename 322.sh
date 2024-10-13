cd
systemctl status isc-dhcp-server | grep -o -P ‘(?<=duid).*(?=iaid)’ | tail -n 1
