library(dplyr)

#load eletronic power consumption data
epc <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                  stringsAsFactors=FALSE, dec =".")

#select only data for 1/2/2007 & 2/2/2007
epcsub <- filter(epc, Date == "1/2/2007" | Date == "2/2/2007")

#convert dates
dttm <- paste(as.Date(epcsub$Date, format="%d/%m/%Y"), epcsub$Time)
epcsub$dttm <- as.POSIXct(dttm)

#plot 2 - global active power consumption by date & time
plot(epcsub$Global_active_power~epcsub$dttm, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")

#save to png file with width and height of 480 pixels
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
