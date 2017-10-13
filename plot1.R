# Load libraries

library(tidyr)
library(lubridate)

# Assign file url and filenames to variables

url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file1 <- "datafile.zip"

# If file with filename exists, don't download, it's huge! If it's not there, then download, and unzip

if(!file.exists(file1)) {
    dataset <- download.file(url1, file1, method = "curl")
    unzip(file1, exdir = ".")
}

# Read table into R, assigning "?" to NA's

testing <- read.table("household_power_consumption.txt", 
                      na.strings = "?", sep = ";",
                      header = TRUE)

# Checks if Date from reading table came in with Date class, if not, uses lubridate to convert

if(class(testing$Date) != "Date") {
    testing$Date <- dmy(testing$Date)
}

# Subsets the data for only two days in question, then transforms time data with lubridate, then adds dates and times to create
# a datetime object
testing.sub <- subset(testing, testing$Date == "2007-02-01" | testing$Date == "2007-02-02")
testing.sub$Time <- hms(testing.sub$Time)
testing.sub$Date.Time <- testing.sub$Date + testing.sub$Time

# Creates plot1.png 

png(filename = "plot1.png", bg = "white", width = 480, height = 480, units = "px")
with(testing.sub, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()
