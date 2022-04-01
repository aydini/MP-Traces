# usage
# processWebServerDat.sh  rawWebBrowsingDataFolderName  > outputFileName
dir=$1 # don't end with /
files=`ls $dir`
echo "filename,path,counter,url,downloadTime"
for f in $files; do
  file="$dir/$f"
  # sample clock time outputs:
  # webBrowsingExperimentData/1_p8t3M:Total wall clock time: 15m 16s                                                                   
  # webBrowsingExperimentData/34_p8t3M:Total wall clock time: 15m 15s                                                                  
  # webBrowsingExperimentData/35_p8t3:Total wall clock time: 1m 10s                                                                    
  # webBrowsingExperimentData/34_p7t1C:Total wall clock time: 0.5s
  clockTime=`grep  "clock time" $file | awk '{print $5 $6}'| tr -d 's'`
  minuteFound=$(echo $clockTime | grep 'm')
  if [ -z "$minuteFound" ]; then
    time=$clockTime:wq
  else
    minutes=$(echo $clockTime | cut -d'm' -f 1)
    seconds=$(echo $clockTime | cut -d'm' -f 2)
    time=$(echo "$minutes*60+$seconds" | bc)
  fi                                                                                                                                   
  url=`head -n 1 $file  | cut -d '/'  -f 4`
  path=`echo $f | cut -d'_' -f 2`
  counter=`echo $f | cut -d'_' -f 1`
  echo "$f,$path,$counter,$url,$clockTime"
done
