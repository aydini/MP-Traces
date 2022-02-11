# run this script at each router to set up the varying bandwidth from real traces
# $1: the name of the trace file to read from the github repo 

#!/bin/bash

ifacetoS=$(ifconfig | grep -B1 "inet 192.168.3.2\|inet 192.168.4.2" | head -n1 | cut -f1 -d:)

# the trace file format is CSV as timeInSeconds,ThruputInBytes
while true; do
cat "$1" | tr -d '\r' | while IFS=, read -r t tput # t for time
do
        if [ "$tput" = "0" ] ; then
                tput=100
        fi
        tputkbit=$( bc <<< "scale=2; $tput/1000*8" )        
        echo $tputkbit
        cmd="sudo tc class replace dev $ifacetoS parent 1: classid 1:3 htb rate ${tputkbit}kbit" 
        # echo $cmd
        eval "$cmd"
        sleep 1
done
done
