dir=$1 # don't end with /
files=`ls $dir`
echo "file,path,counter,url,downloadTime"
for f in $files; do
  file="$dir/$f"
  clockTime=`grep  "clock time" $file | awk '{print $5 $6}'| tr -d 's'`
  url=`head -n 1 $file  | cut -d '/'  -f 4`
  path=`echo $f | cut -d'_' -f 2`
  counter=`echo $f | cut -d'_' -f 1`
  echo "$f,$path,$counter,$url,$clockTime"
done
