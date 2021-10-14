library(ggplot2) 

df <- data.frame(time=integer(),
                 Bps=integer(),
                 path=factor(),
                 network=factor(),
                 trial=factor()
                 )
################## Read in data for path 11
config<-"2021-08-11-16:40:01.pcap-PROCESSED"
csvFolder <- paste('http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/',config,'/', sep ='' ) #use ending /
csvFiles  <-  c('4__1628714731.146211000__172.58.230.250__46064__199.109.64.50__80.pcap.csv',
		'5__1628714735.827463000__192.42.55.22__2342__199.109.64.50__80.pcap.csv',
		'7__1628714994.446249000__172.58.230.250__55982__199.109.64.50__80.pcap.csv',
		'8__1628714999.759233000__192.42.55.22__28214__199.109.64.50__80.pcap.csv',
		'9__1628715250.735406000__172.58.230.250__22557__199.109.64.50__80.pcap.csv',
		'10__1628715254.875998000__192.42.55.22__40196__199.109.64.50__80.pcap.csv',
		'11__1628715468.417467000__172.58.230.250__51346__199.109.64.50__80.pcap.csv',
		'12__1628715474.515628000__192.42.55.22__18741__199.109.64.50__80.pcap.csv',
		'13__1628715715.550477000__172.58.230.250__57883__199.109.64.50__80.pcap.csv',
		'14__1628715719.393161000__192.42.55.22__26300__199.109.64.50__80.pcap.csv'

)

networkFiles <- c('Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi')
pathFiles <- c(11, 11, 11, 11, 11, 11, 11, 11, 11, 11)
trialFiles <- c(1,1,2,2,3,3,4,4,5,5)

for(i in seq(csvFiles)){
   csvFileFull <-paste(csvFolder,csvFiles[i],sep='')
   dft <- read.csv(csvFileFull, header=FALSE)
   names(dft) <- c("time", "Bps")
   dft$path <- as.factor(pathFiles[i])
   dft$network <- as.factor(networkFiles[i])
   dft$trial <- as.factor(trialFiles[i])
   df <- rbind(df, dft)
}

################## Read in data for path 12
config<-"2021-08-11-17:55:46.pcap-PROCESSED"
csvFolder <- paste('http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/',config,'/', sep ='' ) #use ending /
csvFiles  <- c('2__1628719235.540466000__172.58.230.250__41498__199.109.64.50__80.pcap.csv',
               '3__1628719238.303378000__192.42.55.21__7615__199.109.64.50__80.pcap.csv',
               '6__1628719479.679511000__172.58.230.250__33254__199.109.64.50__80.pcap.csv',
               '7__1628719485.040226000__192.42.55.21__13503__199.109.64.50__80.pcap.csv',
               '13__1628719730.316961000__172.58.230.250__57024__199.109.64.50__80.pcap.csv',
               '14__1628719735.618988000__192.42.55.21__29330__199.109.64.50__80.pcap.csv'
)

networkFiles <- c('Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi')
pathFiles <- c(12, 12, 12, 12, 12, 12)
trialFiles <- c(1,1,2,2,3,3)


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
