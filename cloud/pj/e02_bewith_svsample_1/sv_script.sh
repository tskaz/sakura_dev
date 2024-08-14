IP_BACKEND=@@@ip_backend@@@
GW_BACKEND=@@@gw_backend@@@
NETMASK_BACKEND=@@@netmask_backend@@@

# eth2 configuration
sudo cat > /etc/netplan/02-netcfg.yaml <<_EOF_
network:
  ethernets:
    eth1:
      addresses:
        - $IP_BACKEND/$NETMASK_BACKEND
      dhcp4: 'no'
      dhcp6: 'no'
      gateway4: $GW_BACKEND
      nameservers:
        addresses:
          - 133.242.0.3
          - 133.242.0.4
        search:
          - localdomain
  renderer: networkd
  version: 2
_EOF_

sudo netplan apply

