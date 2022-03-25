# $1: name of the output file to record wget statistics
dir='./testWebBrowsingExperimentData/' # to store the web browsing data
ip=192.168.10.2 # ip1 of the apache web server (client)
outputFile="$1"  # pick names like p{PathNo}t{TrialNo}config where config will be nothing, C for constant, M for memoryless random distribution example: p7t1  p7t1C p7t1M

mkdir -p $dir
counter=0
while true; do
for url in {'engineering.nyu.edu','reddit.com','weather.com','youtube.com','farmingdale.edu'}; do                                                                        
        let counter=$counter+1
	echo "$counter $(date)"
	outputFile="${counter}_${1}"	
        wget -o "${dir}${outputFile}" -p "http://${ip}/${url}/" &
        sleep 10
done                                                                                                            
done
