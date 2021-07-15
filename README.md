# MP-Traces

Repository by Ilknur

### Set up a webserver


Reserve a single InstaGENI node on any InstaGENI site, but when you reserve the resource, make sure to check the "Publicly Routable IP" box.

Find out the publicly routable "hostname" from the GENI Portal.

On the InstaGENI node, install Apache:

```
sudo apt-get update
sudo apt-get install -y apache2
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
