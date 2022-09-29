# install packages
sudo apt update
sudo apt -y install iperf3 net-tools
sudo apt -y install moreutils
sudo apt -y install apache2 # install for the web browsing experiments where client will act as the web server

# run sysctl commands to enable mptcp
sudo sysctl -w net.mptcp.mptcp_enabled=1 
sudo sysctl -w net.mptcp.mptcp_checksum=0

# load and configure mptcp congestion control algorithms
sudo modprobe mptcp_balia 
sudo modprobe mptcp_coupled 
sudo modprobe mptcp_olia 
sudo modprobe mptcp_wvegas

# configure mptcp congestion control algorithm to one
sudo sysctl -w net.ipv4.tcp_congestion_control=balia

# install iproute-mptcp package 
sudo git clone https://github.com/multipath-tcp/iproute-mptcp.git
cd iproute-mptcp 
sudo make 
sudo make install 
cd

# get control and experiment interface names
iface1=$(ifconfig | grep -B1 "inet 192.168.10.2" | head -n1 | cut -f1 -d:)
iface2=$(ifconfig | grep -B1 "inet 192.168.20.2" | head -n1 | cut -f1 -d:)
ifaceC=$(ifconfig | grep -B1 "inet " | head -n1 | cut -f1 -d:) 

# remove Cloudlab created automatically added routes: bring both interfaces of the client node down and then up
sudo ifconfig $iface1 down; sudo ifconfig $iface1 up 
sudo ifconfig $iface2 down; sudo ifconfig $iface2 up

# add the new routes manually 
sudo route add -net 192.168.3.0/24 gw 192.168.10.1 
sudo route add -net 192.168.4.0/24 gw 192.168.20.1

# disable mptcp on control interface and enable in the experiment interfaces
sudo ip link set dev $ifaceC multipath off 
sudo ip link set dev $iface1 multipath on 
sudo ip link set dev $iface2 multipath on 

# Configure routing rules
sudo ip rule add from 192.168.10.2 table 1 
sudo ip rule add from 192.168.20.2 table 2 
sudo ip route add 192.168.10.0/24 dev $iface1 scope link table 1
sudo ip route add 192.168.20.0/24 dev $iface2 scope link table 2 
sudo ip route add 192.168.3.0/24 via 192.168.10.1 dev $iface1 table 1 
sudo ip route add 192.168.4.0/24 via 192.168.20.1 dev $iface2 table 2

# for web browsing traffic experiments: mirror (copy) the following list of the web sites into client that will act as the web server
cd /var/www/html/
sudo wget -e robots=off --wait 1 -H -p -k http://engineering.nyu.edu/
sudo wget -e robots=off --wait 1 -H -p -k http://reddit.com/
sudo wget -e robots=off --wait 1 -H -p -k http://weather.com/  
sudo wget -e robots=off --wait 1 -H -p -k http://wikipedia.com/  
sudo wget -e robots=off --wait 1 -H -p -k http://farmingdale.edu/
