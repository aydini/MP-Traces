#--- set up experiment values
d=`date +%F`-`date +%T` 
fileSize="1GB"
linkType="BOTH" # DEBUGSCRIPTS, WIFI, CELL, BOTH
folder="/var/www/TCPDUMP_FILES/$linkType"
sudo mkdir -p $folder
tcpCC=`cat /proc/sys/net/ipv4/tcp_congestion_control`
interface="eth0"
outputFileName="$folder/tcpdump.$linkType.$tcpCC.$fileSize.$d"

#start trace collection
#sudo tcpdump port 80  -i eth0 -n > $outputFileName

sudo tcpdump port 80 -i $interface -n -w $outputFileName".pcap"

#reading pcap file with tcpdump
#sudo tcpdump -n -r $outputFileName".pcap"
