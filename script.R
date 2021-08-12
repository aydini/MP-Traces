install.packages("ggplot2")
library(ggplot2)

# README: set csvFolder and csvFile etc
path<-"11" # valid streams 4,5  7,8  9,10  11,12  13,14
config<-"2021-08-11-16:40:01.pcap-PROCESSED"
stream1<-4
stream2<-5

csvFile1<-'4__1628714731.146211000__172.58.230.250__46064__199.109.64.50__80.pcap.csv'
csvFile2<-'5__1628714735.827463000__192.42.55.22__2342__199.109.64.50__80.pcap.csv'



csvFolder<-paste('http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/',config,'/', sep ='' ) #use ending /
title<-paste("path", path, config, "blue_cell", stream1, "green_wifi", stream2, sep='_')

csvFileFull1<-paste(csvFolder,csvFile1,sep='')
df1<- read.csv(csvFileFull1, header= FALSE)
xVal1<-unlist(df1[1])
yVal1<-unlist(df1[2]*8/10^6)

csvFileFull2<-paste(csvFolder,csvFile2,sep='')
df2<- read.csv(csvFileFull2, header= FALSE)
xVal2<-unlist(df2[1])
yVal2<-unlist(df2[2]*8/10^6)


p<-ggplot() +
  geom_line(data=df1, aes(x=xVal1, y=yVal1), color = "blue", size = 1)+
  geom_point(data=df1, aes(x=xVal1, y=yVal1), color = "black", size = 1)+
  geom_line(data=df2, aes(x=xVal2, y=yVal2), color = "green", size = 1)+
  geom_point(data=df2, aes(x=xVal2, y=yVal2), color = "black", size = 1)+
  xlab("time (sec)")+
  ylab("Bandwidth (Mbps)")+
  ggtitle(title)
p

pngFile<-paste("path", path, "blue_cell", stream1, "green_wifi", stream2, sep='_')
pngFile<-paste(pngFile, ".png", sep='')
ggsave(pngFile, plot= last_plot())

########install.packages("ggplot2")
########library(ggplot2)

######### README: set csvFolder and csvFile etc
########path<-"12"
########config<-"2021-08-11-17:55:46.pcap-PROCESSED"
########csvFile1<-'2__1628719235.540466000__172.58.230.250__41498__199.109.64.50__80.pcap.csv'
########csvFile2<-'3__1628719238.303378000__192.42.55.21__7615__199.109.64.50__80.pcap.csv'

########csvFolder<-paste('http://webserver.webserver-aydini.ch-geni-net.instageni.nysernet.org/mpTraceFiles/',config,'/', sep = ) #use ending /
########title<-paste("path", path, config, "blue cell", "green wifi", sep=',')

########csvFileFull1<-paste(csvFolder,csvFile1,sep='')
########df1<- read.csv(csvFileFull1, header= FALSE)
########xVal1<-unlist(df1[1])
########yVal1<-unlist(df1[2]*8/10^6)

########csvFileFull2<-paste(csvFolder,csvFile2,sep='')
########df2<- read.csv(csvFileFull2, header= FALSE)
########xVal2<-unlist(df2[1])
########yVal2<-unlist(df2[2]*8/10^6)


########p<-ggplot() +
########  geom_line(data=df1, aes(x=xVal1, y=yVal1), color = "blue", size = 1)+
########  geom_line(data=df2, aes(x=xVal2, y=yVal2), color = "green", size = 1)+
########  xlab("time (sec)")+
########  ylab("Bandwidth (Mbps)")+
########  ggtitle(title)
########  
########p

#########ggplot(df1, aes(x=xVal1, y=yVal1, group=1)) +
#########  geom_line(color="red", size=1)+
#########  xlab("time (sec)")+
#########  ylab("Bandwidth (Mbps)")+
#########  geom_point(color="black", size=1)+
#########  ggtitle(title)

########pngDir='C:\\Users\\ilknu\\Documents\\R\\'
########pngFile<-paste(pngDir,title,'.png',sep='')
########ggsave(pngFile)

