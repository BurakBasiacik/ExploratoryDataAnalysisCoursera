##read and subset data
rawdata<-read.table("household_power_consumption.txt",sep=";", header=TRUE,stringsAsFactors = FALSE) 

data<-subset(rawdata,Date=="1/2/2007" | Date=="2/2/2007")

##change data classes
str(data)
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data[,3:9]<-lapply(data[,3:9],as.numeric)

##plot histogram for Global Active Power

png("plot1.png",height=480, width = 480) ##open png device
hist(data$Global_active_power, col="red",xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off() ##close the device


