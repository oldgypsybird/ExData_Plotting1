# load packages
library(tidyverse)
library(lubridate)

# get file
local.directory <- getwd()
download.path <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path <- paste(local.directory, "data.zip", sep = "/")
download.file(download.path, file.path)

#unzip file
zip.path <- paste(local.directory, "data", sep = "/")
unzip(file.path, exdir = zip.path)

# read data
consumption <- read_delim(paste(zip.path, "household_power_consumption.txt", sep = "/"), delim = ";", na = "?") %>% 
  mutate(Date = dmy(Date)) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# create plot 4
png(file = "plot4.png")

par(mfrow = c(2,2))

#top-left
plot(consumption$Global_active_power, type = "l", ylab = "Global Active Power", xaxt = "n", xlab = "")
axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))

#top-right
plot(consumption$Voltage, type = "l", ylab = "Voltage", xaxt = "n", xlab = "datetime")
axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))

#bottom-left
plot(consumption$Sub_metering_1, type = "l",ylab = "Energy sub metering", xaxt = "n", xlab = "")
lines(consumption$Sub_metering_2, col = "red")
lines(consumption$Sub_metering_3, col = "blue")
axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", lty = 1, col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#bottom-right 
plot(consumption$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime")
axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))

dev.off()
