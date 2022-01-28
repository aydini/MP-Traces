* These are script files for the topology created in Cloudlab that utilize the trace pair data collected (using GENI testbed).
* Use the Cloudlab profile mptcp-auto which is configured to "Execute Commands" from each cloudlab node to (1) clone this Github repo, and (2) auto-run the node script when the profile is instantiated.
* after instantiating profile mptcp-auto you can test it by running iperf at client and server and observing that the data traffic is the total capacity of both paths between client and server
At the server run
```
iperf3 -s -i 0.1
```

At the client run
```
iperf3 -f m -c 192.168.3.1 -C "cubic" -P 1 -i 1 -t 200
```
a sample iperf session output at the client is below
![image](https://user-images.githubusercontent.com/36745106/151589120-2417aa69-fcd3-43f9-a3cd-64494c63a88b.png)
