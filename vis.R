library(ggplot2) 

df <- data.frame(time=integer(),
                 Bps=integer(),
                 path=factor(),
                 network=factor(),
                 trial=factor()
                 )
################### Read in data for path 7
config<-"2021-08-03-16:15:28.pcap-PROCESSED"
csvFolder <- paste('http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/',config,'/', sep ='' ) #use ending /
csvFiles  <-  c('2__1628021915.734065000__172.58.227.147__57472__199.109.64.50__80.pcap.csv',
		'4__1628021929.021405000__192.42.55.21__39728__199.109.64.50__80.pcap.csv',
		'8__1628022118.876242000__172.58.227.147__59194__199.109.64.50__80.pcap.csv',
		'9__1628022141.564395000__192.42.55.21__2709__199.109.64.50__80.pcap.csv',
		'11__1628022353.871282000__172.58.227.147__47103__199.109.64.50__80.pcap.csv',
		'13__1628022372.892744000__192.42.55.21__29410__199.109.64.50__80.pcap.csv',
		'16__1628022659.462398000__172.58.227.147__44546__199.109.64.50__80.pcap.csv',
		'17__1628022665.399316000__192.42.55.21__16310__199.109.64.50__80.pcap.csv',
		'19__1628022927.067215000__172.58.227.147__30704__199.109.64.50__80.pcap.csv',
		'22__1628022931.222630000__192.42.55.21__23419__199.109.64.50__80.pcap.csv'
)

networkFiles <- c('Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi')
pathFiles <- c( 7,7,7,7,7,7,7,7,7,7)
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


#################### Read in data for path 8
config<-"2021-08-04-14:26:18.pcap-PROCESSED"
csvFolder <- paste('http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/',config,'/', sep ='' ) #use ending /
csvFiles  <-  c('2__1628101769.339937000__172.58.227.128__46089__199.109.64.50__80.pcap.csv',
		'3__1628101773.918253000__192.42.55.21__23458__199.109.64.50__80.pcap.csv',
		'4__1628101983.443023000__172.58.227.128__39267__199.109.64.50__80.pcap.csv',
		'5__1628101988.201742000__192.42.55.21__33969__199.109.64.50__80.pcap.csv',
		'6__1628102204.796313000__172.58.227.128__53683__199.109.64.50__80.pcap.csv',
		'7__1628102209.068759000__192.42.55.21__35357__199.109.64.50__80.pcap.csv',
		'10__1628102421.639078000__172.58.227.128__44341__199.109.64.50__80.pcap.csv',
		'11__1628102426.234715000__192.42.55.21__27539__199.109.64.50__80.pcap.csv',
		'12__1628102741.167960000__172.58.227.128__56476__199.109.64.50__80.pcap.csv',
		'13__1628102744.579495000__192.42.55.21__25540__199.109.64.50__80.pcap.csv'
)

networkFiles <- c('Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi', 'Cellular', 'WiFi')
pathFiles <- c(8,8,8,8,8,8,8,8,8,8)
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

################ Read in data for path 11
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
q
