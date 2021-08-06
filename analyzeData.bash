# Reference https://serverfault.com/questions/273066/tool-for-splitting-pcap-files-by-tcp-connection/881221#881221
#Reference https://ask.wireshark.org/question/21680/how-to-export-tcp-throughput-into-csv-over-time/


# README: 
# before running this script update the dir, serverIP and flags
#
FLAG_GET_PER_TCP_STREAM_PCAP=0 # 1(true)
FLAG_GET_CSV_FILES=1 # 1(true)
dir=/mnt/mpTraceFiles #.pcap file director, put no ending /
serverIP="199.109.64.50"
        
if [ $# -lt 1 ]
then
	echo; echo "usage:" ; echo " $0  collectivePcapFileName"; echo
else
	file="$1" #.pcap file
        outDir="${dir}/${file}-PROCESSED" # for individual TCP stream pcap files

	#----------------------------------------------------------------------
	# get the pcap files per TCP stream inside the collectivePcapFileName
	#-----------------------------------------------------------------------
	if [ $FLAG_GET_PER_TCP_STREAM_PCAP -eq 1 ]
	then
		sudo rm -rf $outDir; sudo mkdir $outDir

		echo "analzing pcap file ${dir}/${file}..."
		tshark -Tfields -e tcp.stream \
				-e frame.time_epoch \
				-e ip.src \
				-e tcp.srcport \
				-e ip.dst \
				-e tcp.dstport -r "${dir}/${file}" |
		  sort -snu |
		  while read -a f; do 
		  [[ "${f[5]}" ]] || continue  # sometimes there is no stream number ex. UDP
		    fileout=$(echo ${f[0]}__${f[1]}__${f[2]}__${f[3]}__${f[4]}__${f[5]})
		    tshark -r "${dir}/${file}" -2R "tcp.stream == ${f[0]}" -w "$fileout.pcap"
		  done

		  
		sudo mv *__*pcap $outDir
		echo "finished see TCP stream pcap files in ${outDir}"; echo " "
	fi

	#----------------------------------------------------------------------
	# get the csv trace files per pcap files per TCP stream
	#-----------------------------------------------------------------------
	if [ $FLAG_GET_CSV_FILES -eq 1 ]
	then	
		for streamFile in `ls $outDir/*.pcap`
		do
			echo "processing stream pcap file $streamFile to get csv file..."
			tsharkFile="${streamFile}.tshark.txt"
			csvFile="${streamFile}.csv"
			echo "tsharkFile is $tsharkFile"
			echo "csvFile is $csvFile"
			sudo tshark -r "${streamFile}" -q -z io,stat,1,"BYTES()ip.src ==$serverIP" | tee $tsharkFile
			# example input line is as below and we create/output a time,throughput line
			#|   0 <>   1 |  9966648 |              |
			cat $tsharkFile | grep "^| *[0-9]* *<> *[0-9]* *|" | tr -d ' <' | tr '>' '|' | awk -F"|" '{print $3","$4}' | tee $csvFile 
		done
		echo "finished see the csv files in ${outDir}"; echo " "
	fi	
fi


