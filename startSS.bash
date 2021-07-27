outDir=/mnt/MP-TRACE-FILES
outputFileName=`date +%F`-`date +%T`

while true
do 
	ss --no-header -eipn dst :80 or src :80 | ts '%.S' | tee -a $outDir/${outputFileName}".ss.txt"
	sleep 0.1
done
