# MP-Traces

Repository by Ilknur

## Set up a webserver

Reserve a single InstaGENI node as a Xen VM on any InstaGENI site, but when you reserve the resource make sure 
1) to check the "Publicly Routable IP" box (after the reservation, find out the publicly routable "hostname" from the GENI Portal by following Aggregates menu item  and then Resource Details)
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

After the resources are reserved, prepare the extra disk space on the InstaGENI node:
```
sudo   /usr/testbed/bin/mkextrafs   /mnt
sudo chmod a+w /mnt
df -h
```

On the InstaGENI node, install Apache. Also install tshark for data analysis, and screen for running processes in background:

```
sudo apt-get update
sudo apt-get install -y apache2 tshark screen
```

Create a large data file in the web server root directory (/var/www or /var/www/html):

```
sudo dd if=/dev/zero bs=512 count=2097152 of=/var/www/html/testFile.1GB
```

Clone this repository on the server:

```
git clone https://github.com/aydini/MP-Traces.git
cd MP-Traces
```

## Capture packets

Before starting a set of experiments start tcpdump and ss at the webserver.

### Start tcpdump on web server
About the tcpdump session:
1) use -s66 option for capturing header size of 66B =14B for Ethernet + 20B for IP + 20B for TCP
2) use ifconfig command to get the interface information for the public ip of the web server for -i option. 
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
Start a screen session. Run [startTcpdump.bash](startTcpdump.bash) to start tcpdump session to save all of the tcp conversations from multiple expriment trials into a single pcap file.

### Start ss on web server

Install moreutils for ts command

```
sudo apt-get update
sudo apt-get install moreutils
```

Start a screen session.  Run [startSS.bash](startSS.bash) to start ss to collect statistics on port 80 and save output every 0.1 sec to a text file 

### Running Experiments
While running experiments, keep track of the details of each trial. An experiment trial is defined as connecting to the web server via a client device with a WiFi interface and another client device with a cellular interface simultaneously to download the data file. Note that the client devices are physically located in the same position and are made to move together to imitate the behaviour of a single client device with 2 interfaces (WiFi + cellular). 

Use a web browser or wget at the client device to connect to the web server and download the data file at the client device using the public URL for the data file. 

If you are using a web browser to download the data file, make sure to turn off the parallel downloading b setting the browser flags/configurationf ile accourdingly. 

```
wget  dataFilePublicURL
```  
 
When the experiments are over, stop the packet capture at the web server for tcpdump and ss with Ctrl+C.

## Data Analysis
Start a screen session.  Run [analyzeData.bash](analyzeData.bash) to do the following in order
1) extract data from the pcap file by creating a new pcap file per TCP conversation in the captured pcap file
2) analyze each pcap packet to get the trace files tshark.txt files and from that file a csv file in time,throughput csv format.
3) ???create an [R script file](script.R) for each .csv file to draw the data as line graph and save the plot as a .png file
```
install.packages("ggplot2")
library(ggplot2)

# README: before using this R script set csvFolder and csvFile variables accordingly
csvFolder='http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/2021-07-27-18:53:22.pcap-PROCESSED/' #use ending /
csvFile<-'1__1627426664.194789000__192.42.55.21__34482__199.109.64.50__80.pcap.csv'
csvFileFull<-paste(csvFolder,csvFile,sep='')

df<- read.csv(csvFileFull, header= FALSE)
title<-csvFile

xVal<-unlist(df[1]) # unit is econds
yVal<-unlist(df[2]*8/10^6) # convert bytes to Mbps

ggplot(df, aes(x=xVal, y=yVal, group=1)) +
  geom_line(color="green", size=1)+
  xlab("time (sec)")+
  ylab("Bandwidth (Mbps)")+
  geom_point(color="black", size=1)+
  ggtitle(title)

pngDir='C:\Users\ilknu\Documents\R\'
pngFile<-paste(pngDir,csvFile,'.png', sep='')
ggsave(pngFile)

```
