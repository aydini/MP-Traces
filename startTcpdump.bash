outDir=/mnt/mpTraceFiles
outputFileName=`date +%F`-`date +%T` 
serverIP="199.109.64.50"
echo "starting tcpdump and saving output to ${outDir}/${outputFileName}.pcap"
sudo tcpdump host $serverIP and port 80 -s 66 -w "${outDir}/${outputFileName}.pcap"
