outDir=/mnt/mpTraceFiles # put no ending /
outputFileName=`date +%F`-`date +%T`

echo "starting ss and saving  output to ${outDir}/${outputFileName}.ss.txt"
while true
do 
	ss --no-header -eipn dst :80 or src :80 | ts '%.S' | tee -a "${outDir}/${outputFileName}.ss.txt"
	sleep 0.1
done
