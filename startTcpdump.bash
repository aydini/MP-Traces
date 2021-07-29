outDir=/mnt/MP-TRACE-FILES
outputFileName=`date +%F`-`date +%T` 
interface="eth0"
echo "starting tcpdump and saving output to ${outDir}/${outputFileName}.pcap"
sudo tcpdump port 80 -i $interface -s 66 -w "${outDir}/${outputFileName}.pcap"
