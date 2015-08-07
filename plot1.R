library(dplyr)

#load eletronic power consumption data
epc <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                  stringsAsFactors=FALSE, dec =".")

#select only data for 1/2/2007 & 2/2/2007
epcsub <- filter(epc, Date == "1/2/2007" | Date == "2/2/2007")

#plot 1- global active power consumption
hist(as.numeric(epcsub$Global_active_power), main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

#save to png file with width and height of 480 pixels
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
