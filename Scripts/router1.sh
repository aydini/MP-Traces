# get control and experiment interface names
ifacetoC=$(ifconfig | grep -B1 "inet 192.168.1.2" | head -n1 | cut -f1 -d:)
ifacetoS=$(ifconfig | grep -B1 "inet 192.168.3.2" | head -n1 | cut -f1 -d:)

# remove Cloudlab created automatically added routes: bring both interfaces of the client node down and then up
sudo ifconfig $ifacetoC down; sudo ifconfig $ifacetoC up 
sudo ifconfig $ifacetoS down; sudo ifconfig $ifacetoS up

# add the new routes manually 
sudo route add -net 192.168.10.0/24 gw 192.168.1.1 
