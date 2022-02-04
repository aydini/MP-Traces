The Cloudlab topology below will the trace pair data collected (using GENI testbed) for mptcp experiments

# Cloudlab Topology

add the picture of topology...

add source of picture...

# Setup Cloudlab topology and configure nodes

Use the Cloudlab profile **mptcp-auto** which is configured to autimatically "Execute Commands" from each cloudlab node at instantiation to (1) clone this Github repo, and (2) auto-run the corresponding node script.

After instantiating the profile, test it by running iperf at client and server and observing that the data traffic is about the total capacity of both paths between client and server

At the server run
```
iperf3 -s -i 0.1
```

At the client run
```
iperf3 -f m -c 192.168.3.1 -C "balia" -P 1 -i 1 -t 200
```
a sample iperf session output at the client is below. Note that MPTCP is selcted by specifying a MPTCP CC algorithm 'balia'. You should see the bandwidth to be close tot he total capacity of both paths.  
```
aydini1@client:~$ iperf3 -f m -c 192.168.3.1 -C "balia" -P 1 -i 1 -t 200
Connecting to host 192.168.3.1, port 5201                               
[  4] local 192.168.10.2 port 33924 connected to 192.168.3.1 port 5201  
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd        
[  4]   0.00-1.00   sec  20.4 MBytes   171 Mbits/sec    0   14.1 KBytes 
[  4]   1.00-2.00   sec  22.2 MBytes   187 Mbits/sec    0   14.1 KBytes 
[  4]   2.00-3.00   sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]   3.00-4.00   sec  22.4 MBytes   188 Mbits/sec    0   14.1 KBytes 
[  4]   4.00-5.00   sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]   5.00-6.00   sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]   6.00-7.00   sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]   7.00-8.00   sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]   8.00-9.00   sec  22.4 MBytes   188 Mbits/sec    0   14.1 KBytes 
[  4]   9.00-10.00  sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]  10.00-11.00  sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]  11.00-12.00  sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]  12.00-13.00  sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]  13.00-14.00  sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
[  4]  14.00-15.00  sec  22.5 MBytes   189 Mbits/sec    0   14.1 KBytes 
```
