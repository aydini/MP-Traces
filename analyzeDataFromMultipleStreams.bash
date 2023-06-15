# Reference https://serverfault.com/questions/273066/tool-for-splitting-pcap-files-by-tcp-connection/881221#881221
#Reference https://ask.wireshark.org/question/21680/how-to-export-tcp-throughput-into-csv-over-time/

# README: 
# 1) make sure that you run sudo su before running this script
# 2) before running this script update the dir, serverIP and flags
#
FLAG_GET_PER_TCP_STREAM_PCAP=0 # (true)
FLAG_GET_CSV_FILES=1 # 1(true)
dir=/mnt/c/ILKNUR/RAW_PCAP_FILES # don't add / to the end
serverIP='155.98.37.86' # since we are not analyzing pcap files on the server we hard coded the serveIP


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

#		for 2023-04-25-12_53_45.pcap		
#		cellularIP='172.102.12.145' #edit cellularIP and wifiIP per raw pcap file	
#		wifiIP='137.125.151.201'

#		for 2023-04-26-10_48_05.pcap
#		cellularIP='172.102.12.3' #edit cellularIP and wifiIP per raw pcap file	
#		wifiIP='137.125.132.15'

#		for 2023-04-26-10_49_49.pcap
#		cellularIP='172.102.12.3' #edit cellularIP and wifiIP per raw pcap file	
#		wifiIP='137.125.132.15'

#		for 2023-04-26-10_57_26.pcap
#		cellularIP='172.102.12.3' #edit cellularIP and wifiIP per raw pcap file	
#		wifiIP='137.125.132.15'

#		for 2023-04-26-10_58_43.pcap		
		cellularIP='172.102.12.3' #edit cellularIP and wifiIP per raw pcap file	
		wifiIP='137.125.132.15'

		fileoutcellular=${cellularIP}'__googlefi_cellular'
		fileoutwifi=${wifiIP}'__fscwifi'
		echo "fileoutcellular: $fileoutcellular"
		echo "fileoutwifi: $fileoutwifi"
		sudo tshark -r "${dir}/${file}" -2R "ip.addr == ${cellularIP}" -w "$fileoutcellular.pcap"
		sudo tshark -r "${dir}/${file}" -2R "ip.addr == ${wifiIP}" -w "$fileoutwifi.pcap"


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
			bytes=`cat $tsharkFile | grep "<>" | cut -f3 -d'|' | awk  '{sum+=$1;} END{print sum;}'`
			if [ $bytes -gt 1000000 ] # filter the tshark outout by total bytes transferred
			then	
				# example input line is as below and we create/output a time,throughput line
				#|   0 <>   1 |  9966648 |              |
				cat $tsharkFile | grep "^| *[0-9]* *<> *[0-9]* *|" | tr -d ' <' | tr '>' '|' | awk -F"|" '{print $3","$4}' | tee $csvFile 
			fi
		done
		echo "finished see the csv files in ${outDir}"; echo " "
	fi	
fi


