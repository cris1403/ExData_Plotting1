rm(list=ls())
setInternet2(use = TRUE)  

# download data
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/household_power_consumption.zip", mode="wb")
data = read.table(unzip("./data/household_power_consumption.zip"), 
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

png(filename="plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2),  mar = c(4, 4, 4, 3), oma = c(0, 0, 2, 0))

plot(subdata$Datetime, subdata$Global_active_power, type='l',
     xlab="",
     ylab="Global Active Power",
     cex.lab=0.8, cex.axis=0.75
)

plot(subdata$Datetime, subdata$Voltage, type='l',
     xlab="datetime",
     ylab="Voltage",
     cex.lab=0.8, cex.axis=0.75
)

plot(subdata$Datetime, subdata$Sub_metering_1, type='l',
     xlab="",
     ylab="Energy sub metering",
     cex.lab=0.8, cex.axis=0.75
)
lines(subdata$Datetime, subdata$Sub_metering_2, type='l', col="red")
lines(subdata$Datetime, subdata$Sub_metering_3, type='l', col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1.5,
       col=c("black","red","blue"), cex=0.9, bty="n")

plot(subdata$Datetime, subdata$Global_reactive_power, type='l',
     xlab="datetime",
     ylab="Global_reactive_power",
     cex.lab=0.8, cex.axis=0.75
)
dev.off()