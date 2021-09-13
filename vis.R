library(ggplot2) 

# Read in data

config<-"2021-08-11-17:55:46.pcap-PROCESSED"
csvFolder <- paste('http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/',config,'/', sep ='' ) #use ending /
csvFiles  <- c('2__1628719235.540466000__172.58.230.250__41498__199.109.64.50__80.pcap.csv',
              '3__1628719238.303378000__192.42.55.21__7615__199.109.64.50__80.pcap.csv',
              '2__1628719235.540466000__172.58.230.250__41498__199.109.64.50__80.pcap.csv',
              '3__1628719238.303378000__192.42.55.21__7615__199.109.64.50__80.pcap.csv',
              '2__1628719235.540466000__172.58.230.250__41498__199.109.64.50__80.pcap.csv',
              '3__1628719238.303378000__192.42.55.21__7615__199.109.64.50__80.pcap.csv',
              '2__1628719235.540466000__172.58.230.250__41498__199.109.64.50__80.pcap.csv',
             '3__1628719238.303378000__192.42.55.21__7615__199.109.64.50__80.pcap.csv'
             )

networkFiles <- c('Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi')
pathFiles <- c(12, 12, 12, 12, 14, 14, 14, 14)
trialFiles <- c(1,1,2,2,1,1,2,2)

df <- data.frame(time=integer(),
                 Bps=integer(),
                 path=factor(),
                 network=factor(),
                 trial=factor()
                 )

for(i in seq(csvFiles)){
   csvFileFull <-paste(csvFolder,csvFiles[i],sep='')
   dft <- read.csv(csvFileFull, header=FALSE)
   names(dft) <- c("time", "Bps")
   dft$path <- as.factor(pathFiles[i])
   dft$network <- as.factor(networkFiles[i])
   dft$trial <- as.factor(trialFiles[i])
   df <- rbind(df, dft)
}

# Plot

q <- ggplot(df) + geom_line(aes(x=time, y=Bps*8/10^6, colour=network)) + facet_grid(trial~path)
