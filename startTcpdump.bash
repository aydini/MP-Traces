outDir=/mnt/mpTraceFiles
outputFileName=$(ip route get 8.8.8.8 | awk '{print $7}' | head -n 1)
serverIP="199.109.64.50"
echo "starting tcpdump and saving output to ${outDir}/${outputFileName}.pcap"
#sudo tcpdump host $serverIP and port 80 -s 66 -w "${outDir}/${outputFileName}.pcap"

sudo tcpdump \(src host $serverIP and src port 80\) or \(dst host $serverIP and dst port 80\) -s 66 -w  "${outDir}/${outputFileName}.pcap"
