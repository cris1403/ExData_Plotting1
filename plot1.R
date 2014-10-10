rm(list=ls())
setInternet2(use = TRUE)  

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip?accessType=DOWNLOAD"
download.file(fileUrl, destfile="../data/household_power_consumption.zip", mode="wb")
data = read.table(unzip("../data/household_power_consumption.zip", exdir="../data"), 
                  sep=";", 
                  header=TRUE, 
                  stringsAsFactors=FALSE,
                  na.strings="?")

datetime = paste0(data$Date, data$Time, sep=" ")
data$Datetime = strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
data$Date = as.Date(data$Date, format = "%d/%m/%Y")

datetime = NULL

data$Global_active_power = as.numeric(data$Global_active_power)
data$Global_reactive_power = as.numeric(data$Global_reactive_power)
data$Voltage = as.numeric(data$Voltage)
data$Global_intensity = as.numeric(data$Global_intensity)
data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
data$Sub_metering_3 = as.numeric(data$Sub_metering_3)

subdata = subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

png(filename="plot1.png", width = 480, height = 480)
hist(subdata$Global_active_power, col="red", main = "Global Active Power",
     xlab="Global Active Power (kilowatts)",
     cex.lab=1, cex.axis=1, cex.main=1.2
)
dev.off()