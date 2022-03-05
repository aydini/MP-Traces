# $1: name of the output file to record wget statistics
ip=192.168.10.2 # ip1 of the apache web server (client)
outputFile="$1"

while true; do
for url in {'engineering.nyu.edu','reddit.com'}; do
        # last part of wget output
        #       Total wall clock time: 5.2s
        # output line format is: url,timeInSeconds
        wget -p "http://${ip}/${url}/" 2>&1 | awk '/Total wall clock time/{print $5}'| awk -F's' -v url=$url '{print url "," $1}' >> $outputFile
        sleep 2
done
done
