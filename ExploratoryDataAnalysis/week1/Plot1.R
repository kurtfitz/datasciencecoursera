## Week 1 Course Project File

## Use the data.table library and fread for better performance

if(!file.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("data/household_power_consumption.zip")

library(data.table)

## First Plot:

DT <- fread("data/household_power_consumption.txt", na.strings = "?")
DT <- DT[as.Date(Date, "%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02"]

png(file ="plot1.png", width=480, height=480)

with(DT, 
  hist(as.numeric(DT$Global_active_power), 
       ylab = "Frequency", 
       xlab = "Global Active Power (kilowatts)", 
       col="red",
       main="Global Active Power")
  )
dev.off()
