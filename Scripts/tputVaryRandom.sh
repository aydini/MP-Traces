# run this script at each router to set up the varying bandwidth from a (random) memoryless process
# $1: mean data rate
# $2: standard deviation of the data rate

#!/bin/bash

ifacetoS=$(ifconfig | grep -B1 "inet 192.168.3.2\|inet 192.168.4.2" | head -n1 | cut -f1 -d:)

while true; do
  tputmbit=$(python3 -c "import random; print(random.gauss($1, $2))")
  tputkbit=$( bc <<< "scale=2; $tputmbit*1000" )   
  if (( $(echo "0 > $tputkbit" |bc -l) )); then  
    tputkbit=1
  fi
            
  echo $tputkbit
  cmd="sudo tc class replace dev $ifacetoS parent 1: classid 1:3 htb rate ${tputkbit}kbit" 
  # echo $cmd
  eval "$cmd"
  sleep 1
done
