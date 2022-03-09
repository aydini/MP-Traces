# $1: name of the output file to record wget statistics
dir='./webBrowsingExperimentData/' # to store the web browsing data
ip=192.168.10.2 # ip1 of the apache web server (client)
outputFile="$1"  # pick names like p{PathNo}t{TrialNo}config where config will be nothing, C for contant, M for memoryless random distribution example: p7t1  p7t1C p7t1M

while true; do
for url in {'engineering.nyu.edu','reddit.com','facebook.com','youtube.com','farmingdale.edu'}; do                                                                        
        # last part of wget output
        #       Total wall clock time: 5.2s
        # output line format is: url,timeInSeconds
        wget -p "http://${ip}/${url}/" 2>&1 | awk '/Total wall clock time/{print $5}'| awk -F's' -v url=$url '{print url "," $1}' >> "${dir}${outputFile}"
        sleep 2
done                                                                                                            
done
