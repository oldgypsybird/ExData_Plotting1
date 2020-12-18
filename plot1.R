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

# create plot 1
png(file = "plot1.png")
hist(consumption$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")   
dev.off()





png(file = plot2.png)

plot(consumption$Global_active_power, type = "l", ylab = "Globacl Active Power (kilowatts)")
axis(1)