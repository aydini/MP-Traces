# reference https://serverfault.com/questions/273066/tool-for-splitting-pcap-files-by-tcp-connection/881221#881221


# README: 
# before running this script update the dir, serverIP
#
if [ $# -lt 1 ]
then
	echo; echo "usage:" ; echo " $0  collectivePcapFileName"; echo
else
	#----------------------------------------------------------------------
	# get the pcap files per TCP stream inside the collectivePcapFileName
	#-----------------------------------------------------------------------
	#
        dir=/mnt/mpTraceFiles #.pcap file director, put no ending /
        serverIP="199.109.64.50"
        file="$1" #.pcap file
        outDir="${dir}/${file}-PROCESSED" # for individual TCP stream pcap files
########sudo rm -rf $outDir; sudo mkdir $outDir

########echo "analzing pcap file ${dir}/${file}..."
########tshark -Tfields -e tcp.stream \
########		-e frame.time_epoch \
########		-e ip.src \
########		-e tcp.srcport \
########		-e ip.dst \
########		-e tcp.dstport -r "${dir}/${file}" |
########  sort -snu |
########  while read -a f; do 
########  [[ "${f[5]}" ]] || continue  # sometimes there is no stream number ex. UDP
########    fileout=$(echo ${f[0]}__${f[1]}__${f[2]}__${f[3]}__${f[4]}__${f[5]})
########    tshark -r "${dir}/${file}" -2R "tcp.stream == ${f[0]}" -w "$fileout.pcap"
########  done

########  
########sudo mv *__*pcap $outDir
########echo "finished see TCP stream pcap files in ${outDir}"


	#----------------------------------------------------------------------
	# get the csv trace files per pcap files per TCP stream
	#-----------------------------------------------------------------------
	for streamFile in `ls $outDir/*.pcap`
	do
		echo "processing stream pcap file $streamFile to get csv file..."
		tsharkFile="${streamFile}.tshark.txt"
		csvFile="${streamFile}.csv"
		sudo tshark -r "${streamFile}" -q -z io,stat,1,"BYTES()ip.src ==$serverIP" > $tsharkFile
		# example input line 
		#|   0 <>   1 |  9966648 |              |
		cat $tsharkFile | grep "^| *[0-9]* *<> *[0-9]* *|" | tr -d ' <' | tr '>' '|' | awk -F"|" '{print $3","$4}' > $csvFile 
	done
   
	echo "finished see the csv files in ${outDir}"
fi


