# get control and experiment interface names
iface1=$(ifconfig | grep -B1 "inet 192.168.10.1" | head -n1 | cut -f1 -d:)
iface2=$(ifconfig | grep -B1 "inet 192.168.1.1" | head -n1 | cut -f1 -d:)

# remove Cloudlab created automatically added routes: bring both interfaces of the client node down and then up
sudo ifconfig $iface1 down; sudo ifconfig $iface1 up 
sudo ifconfig $iface2 down; sudo ifconfig $iface2 up


# add the new routes manually 
sudo route add -net 192.168.3.0/24 gw 192.168.1.2
