library(dplyr)

#load eletronic power consumption data
epc <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                  stringsAsFactors=FALSE, dec =".")

#select only data for 1/2/2007 & 2/2/2007
epcsub <- filter(epc, Date == "1/2/2007" | Date == "2/2/2007")

#convert dates
dttm <- paste(as.Date(epcsub$Date, format="%d/%m/%Y"), epcsub$Time)
epcsub$dttm <- as.POSIXct(dttm)

#plot 3 - energy sub metering consumption by date & time
with (epcsub, {plot(epcsub$Sub_metering_1~epcsub$dttm, type="l", xlab="",
     ylab="Energy sub metering")
     lines(epcsub$Sub_metering_2~epcsub$dttm, col="red")
     lines(epcsub$Sub_metering_3~epcsub$dttm, col="blue")})

#legend for plot
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lwd= 1, cex=0.8)

#save to png file with width and height of 480 pixels
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
