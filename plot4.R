library(dplyr)

#load eletronic power consumption data
epc <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                  stringsAsFactors=FALSE, dec =".")

#select only data for 1/2/2007 & 2/2/2007
epcsub <- filter(epc, Date == "1/2/2007" | Date == "2/2/2007")

#convert dates
dttm <- paste(as.Date(epcsub$Date, format="%d/%m/%Y"), epcsub$Time)
epcsub$dttm <- as.POSIXct(dttm)

#diagrams to be in 2 rows and 2 columns
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

#diagram mfrow(1,1) - global active power consumption by date & time
plot(epcsub$Global_active_power~epcsub$dttm, type="l", xlab="",
     ylab="Global Active Power")

#diagram mfrow(1,2) - voltage consumption by date & time
plot(epcsub$Voltage~epcsub$dttm, type="l", xlab="datetime", ylab="Voltage")

#diagram mfrow(2,1) - energy sub metering consumption by date & time
with (epcsub, {plot(epcsub$Sub_metering_1~epcsub$dttm, type="l", xlab="",
     ylab="Energy sub metering")
     lines(epcsub$Sub_metering_2~epcsub$dttm, col="red")
     lines(epcsub$Sub_metering_3~epcsub$dttm, col="blue")
     legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lwd=1, cex=0.65, y.intersp=0.7, bty="n")})

#diagram mfrow(2,2) - global reactive power consumption by date & time
plot(epcsub$Global_reactive_power~epcsub$dttm, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

#save to png file with width and height of 480 pixels
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
