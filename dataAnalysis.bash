# refrence https://serverfault.com/questions/273066/tool-for-splitting-pcap-files-by-tcp-connection/881221#881221


# README: 
# run this script in the dir where the file is.
#
dir=/mnt/MP-TRACE-FILES/ #.pcap file
file=2021-07-28-12:43:10.pcap #.pcap file
outDir="${file}-PROCESSED/"
sudo rm -rf $outDir; sudo mkdir $outDir

tshark -Tfields -e tcp.stream \
                -e frame.time_epoch \
                -e ip.src \
                -e tcp.srcport \
                -e ip.dst \
                -e tcp.dstport -r "${dir}${file}" |
  sort -snu |
  while read -a f; do 
  [[ "${f[5]}" ]] || continue  # sometimes there is no stream number ex. UDP
    fileout=$(echo ${f[0]}__${f[1]}__${f[2]}__${f[3]}__${f[4]}__${f[5]})
    tshark -r $file -2R "tcp.stream == ${f[0]}" -w "$fileout.pcap"
  done

  
  sudo mv *__*pcap $outDir
