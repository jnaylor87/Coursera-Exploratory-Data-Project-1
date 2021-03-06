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

#Plot 1
hist(FebElec$Global_active_power/1000, col="red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()
