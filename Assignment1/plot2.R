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

##plot line graph with DateTime and Global Active Power
png("plot2.png",height=480,width=480) ##open png device
plot(data$DateTime,data$Global_active_power,type='l',ylab="Global Active Power (kilowatts)",xlab="")
dev.off()

