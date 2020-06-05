####NOTE THAT X AXIS SHOWS DAY NAMES IN TURKISH AS IT'S THE SYSTEM LOCALE

##read and subset data

rawdata<-read.table("household_power_consumption.txt",sep=";", header=TRUE,stringsAsFactors = FALSE) 

data<-subset(rawdata,Date=="1/2/2007" | Date=="2/2/2007")

##change data classes
str(data)
head(data)
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data[,3:9]<-lapply(data[,3:9],as.numeric)

##add column with date and time combined
##(pasting inside as.POSIXct returned NA, so it was done in two steps, credit to Poja Gulati)

data$DateTime<-paste(data$Date,data$Time)
data$DateTime<-as.POSIXct(data$DateTime)

##plot line graph with DateTime and sub meterings

png("plot3.png",height=480,width=480) ##open png device
plot(data$DateTime,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering") ##start with blank values
lines(data$DateTime,data$Sub_metering_1)
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=colnames(data[7:9]),lwd=1)
dev.off() ##close png device
