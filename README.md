# MP-Traces

Repository by Ilknur

### Set up a webserver


Reserve a single Xen VM node on any InstaGENI site, but when you reserve the resource make sure 
1) to check the "Publicly Routable IP" box (after the reservation, find out the publicly routable "hostname" from the GENI Portal.)
2) to request additional disk space of 100 GB in the Request RSpec using 
```
<emulab:xen cores="2" ram="8192" disk="100"/>
```
inside sliver_type tag of the Request RSpec. 

See below for example RSpec
```
<rspec xmlns="http://www.geni.net/resources/rspec/3" xmlns:emulab="http://www.protogeni.net/resources/rspec/ext/emulab/1" xmlns:tour="http://www.protogeni.net/resources/rspec/ext/apt-tour/1" xmlns:jacks="http://www.protogeni.net/resources/rspec/ext/jacks/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.geni.net/resources/rspec/3    http://www.geni.net/resources/rspec/3/request.xsd" type="request">
  <node xmlns="http://www.geni.net/resources/rspec/3" client_id="webserver">
    <icon xmlns="http://www.protogeni.net/resources/rspec/ext/jacks/1" url="https://portal.geni.net/images/Xen-VM.svg"/>
    <site xmlns="http://www.protogeni.net/resources/rspec/ext/jacks/1" id="Site 1"/>
    <routable_control_ip xmlns="http://www.protogeni.net/resources/rspec/ext/emulab/1"/>
    <sliver_type xmlns="http://www.geni.net/resources/rspec/3" name="emulab-xen">
    <emulab:xen cores="2" ram="8192" disk="100"/>
    <disk_image xmlns="http://www.geni.net/resources/rspec/3" name="urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU18-64-STD"/>
    </sliver_type>
    <services xmlns="http://www.geni.net/resources/rspec/3"/>
  </node>
</rspec>
```


On the InstaGENI node, install Apache. Also install tshark for data analysis, and screen for running processes in background:

```
sudo apt-get update
sudo apt-get install -y apache2 tshark screen
```

Create a large data file in the web server root directory:

```
sudo dd if=/dev/zero bs=512 count=2097152 of=/var/www/testFile.1GB
```

Clone this repository on the server:

```
git clone https://github.com/aydini/MP-Traces.git
cd MP-Traces
```

## Capture packets

Before starting a set of experiments start tcpdump and ss at the webserver:

#### start tcpdump

1) use -s66 option for capturing header size of 66B =14B for Ethernet + 20B for IP + 20B for TCP
2) use ifconfig command to get the interface information for the public ip of the web server to set variable -i option. 
```
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 199.109.64.50  netmask 255.255.255.0  broadcast 199.109.64.255
        inet6 fe80::c1:b9ff:feac:13fa  prefixlen 64  scopeid 0x20<link>
        ether 02:c1:b9:ac:13:fa  txqueuelen 1000  (Ethernet)
        RX packets 451552  bytes 100124136 (100.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 453440  bytes 60142185 (60.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
Then start tcpdump as below.

```
outputFileName=`date +%F`-`date +%T` 
interface="eth0"
sudo tcpdump port 80 -i $interface -s 66 -w $outputFileName".pcap"
```
#### start ss collect whatever you can on port 80 of the webserver and save to an output file

While running experiments, keep track of the details of each trial.

An experiment trial is defined as connecting to the web server via a client device with a WiFi interface and another client device with a cellular interface simultaneously to download the data file. Note that the client devices are physically located in the same position and are made to move together to imitate the behaviour of a single client device with 2 interfaces (WiFi + cellular). 

Use a web browser or wget at the client device to connect to the web server and download the data file using the public URL for the data file.

```
wget  dataFilePublicURL
```  
 
When the experiments are over, stop the packet capture at the web server with Ctrl+C, and extract data with:

```
tshark -Tfields -e tcp.stream -e frame.time_epoch -e frame.len -e ip.src -e tcp.srcport -e ip.dst -e tcp.dstport -E separator=',' -r "$outputFileName".pcap > "$outputFileName".csv
```
Sample output:

```
0,1626370514.241841000,74,69.121.239.12,51586,192.86.139.64,80
0,1626370514.241867000,74,192.86.139.64,80,69.121.239.12,51586
0,1626370514.252236000,66,69.121.239.12,51586,192.86.139.64,80
0,1626370514.253640000,257,69.121.239.12,51586,192.86.139.64,80
```

## ???update??? Data analysis

Assuming a file `test.csv`:

```
library(ggplot2)
library(zoo)

dat <- read.csv("test.csv", header=FALSE)
names(dat) <- c("stream", "time", "size", "srcIP", "srcPort", "dstIP", "dstPort")

# example: for stream 0, downlink traffic only
dat0 <- dat[dat$stream==0 & dat$srcPort==80,]
# create a "time difference" column
dat0$timeDiff <- c(tail(dat0$time, -1) - head(dat0$time, -1), 0)

# next step: compute a windowed sum of time and size columns
# look into e.g. https://stackoverflow.com/q/46396417/3524528
```
