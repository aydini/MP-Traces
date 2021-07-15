# MP-Traces

Repository by Ilknur

### Set up a webserver


Reserve a single InstaGENI node on any InstaGENI site, but when you reserve the resource, make sure to check the "Publicly Routable IP" box.

Find out the publicly routable "hostname" from the GENI Portal.

On the InstaGENI node, install Apache. Also install tshark for data analysis, and screen for running things in background:

```
sudo apt-get update
sudo apt-get install -y apache2 tshark screen
```

Create a large file in the web server root directory:

```
sudo dd if=/dev/zero bs=512 count=2097152 of=/var/www/testFile.1GB
```

Clone this repository on the server:

```
git clone https://github.com/aydini/MP-Traces.git
cd MP-Traces
```


## Capture packets

Before starting a set of experiments,

```
outputFileName=`date +%F`-`date +%T` 
sudo tcpdump port 80 -i $interface -s 66 -w $outputFileName".pcap"
```

While running experiments, keep track of the details of each trial.

When the experiments are over, stop the packet capture with Ctrl+C, and extract data with:

```
tshark -Tfields -e tcp.stream -e frame.time_epoch -e frame.len -e ip.src -e tcp.srcport -e ip.dst -e tcp.dstport -E separator=',' -r "$outputFileName".pcap > "$outputFileName".csv
```
