library(tidyr)
library(lubridate)
setwd("/Users/fer/Dropbox/Coursera DS/Exploratory Data Analysis")

url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file1 <- "datafile.zip"

if(!file.exists(file1)) {
    dataset <- download.file(url1, file1, method = "curl")
    unzip(file1, 
          exdir = "."
          )
}


testing <- read.table("household_power_consumption.txt", 
                      na.strings = "?", 
                      sep = ";",
                      header = TRUE
                      )

if(class(testing$Date) != "Date") {
    testing$Date <- dmy(testing$Date)
}

testing.sub <- subset(testing, 
                      testing$Date == "2007-02-01" | testing$Date == "2007-02-02")
testing.sub$Time <- hms(testing.sub$Time)
testing.sub$Date.Time <- testing.sub$Date + testing.sub$Time

png(filename = "plot4.png", 
    bg = "white", 
    width = 480, 
    height = 480, 
    units = "px"
    )

par(mfrow = c(2, 2))

with(testing.sub, {
    plot(x = Date.Time, 
         y = Global_active_power, 
         xlab = "Global Active Power", 
         type = "l"
        )
    
    plot(x = Date.Time, 
         y = Voltage, 
         type = "l", 
         xlab = "datetime"
        )
    
    plot(x = Date.Time, 
         y = Sub_metering_1, 
         ylab = "Energy sub metering", 
         xlab ="", 
         type = "l"
        )
    
    lines(x = Date.Time, 
          y = Sub_metering_2, 
          col = "red"
          )
    
    lines(x = Date.Time, 
          y = Sub_metering_3, 
          col = "blue"
          )
    
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "red", "blue"), 
           lty = c(1, 1, 1),
           bty = "n"
        )
    
    plot(x = Date.Time, 
         y = Global_reactive_power, 
         type = "l", 
         xlab = "datetime"
        )
    
    }
)

dev.off()