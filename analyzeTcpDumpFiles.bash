linkType="WIFI" # DEBUGSCRIPTS, WIFI, CELL, BOTH
tcpDumpFolder="/var/www/TCPDUMP_FILES/$linkType"
traceFolder="/var/www/TRACE_FILES/$linkType"
sudo mkdir -p $traceFolder 
sourc="192.86.139.64"
destination="108.30.61.30"

for dumpFile in `ls $tcpDumpFolder/*`
do
	
	echo "analyzing dump file $dumpFile"
	traceFile=`echo $dumpFile | sed 's/^.*\///'` # remove path from dumpFile
	traceFile="$traceFolder/$traceFile.trace" # create the traceFile in the traceFolder
	echo "trace file is $traceFile"
 	sudo touch $traceFile	
	
	head -100 $dumpFile | grep "$sourc.80 > $destination.*seq.*:.*" | cut -d' ' -f 1,15|  sed 's/.$//' | cut -d":" -f3| awk '\
	BEGIN{start=1}
	/./{
		if (start == 1) # reading the first line of the trace file
		{       	
			startTime=$1;
			subTotal=0;
			start=0;
			count=1;
			print "if";
		}	
		else
		{
			printf "%f,%f,%f\n",$1, startTime, $1-startTime;
			if ($1-startTime < 1.000001) # find the data send in the current second
			{
				subTotal=subTotal+$2
				shortTraceFile=1 # assume that the trace file has <1 sec. data
			}
			else
			{
				printf "%d,%f,%d,bytes/sec\n",count,startTime,",", subTotal;
				startTime=$1;
				subTotal=0;
				count++;
				shortTraceFile=0
			}
		}

	}
        END{
        	if (shortTraceFile == 1)
        	{
        			
			printf "%d,%f,%d,bytes/sec\n",count,startTime, subTotal/($1-startTime);
        	}

        }
	' > delete.trace # end of awk
done
       
