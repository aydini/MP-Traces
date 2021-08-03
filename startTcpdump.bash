outDir=/mnt/mpTraceFiles
outputFileName=`date +%F`-`date +%T` 
destIP="199.109.64.50"
echo "starting tcpdump and saving output to ${outDir}/${outputFileName}.pcap"
sudo tcpdump dst $destIP and dst port 80 -s 66 -w "${outDir}/${outputFileName}.pcap"
