#Packages and Libraries
library(downloader)
library(readr)
library(tidyverse)
library(lubridate)

# Download Dataset and Unzip
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(url, dest="~/electric.zip", mode="wb") 
unzip("electric.zip")

electricity<-read.table("~/household_power_consumption.txt",sep=";",header=TRUE)

electricity[electricity=="?"]<-NA
electricity$DateTime<-dmy_hms(paste(electricity$Date,electricity$Time))
electricity$Global_active_power<-as.numeric(electricity$Global_active_power)
FebElec<-subset(electricity,DateTime >= "2007/02/01" & DateTime < "2007/02/03")

#Plot 3
plot(FebElec$DateTime,FebElec$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering")
points(FebElec$DateTime,FebElec$Sub_metering_2,type = "l",col="red")
points(FebElec$DateTime,FebElec$Sub_metering_3,type = "l",col="blue")
legend("topright",legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col=c("black","red","blue"),lty=1)
dev.copy(png,'plot3.png',width=480,height=480)
dev.off()