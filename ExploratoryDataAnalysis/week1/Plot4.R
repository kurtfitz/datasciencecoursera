
if(!file.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("data/household_power_consumption.zip")

library(data.table)

## Fourth Plot :

DT <- fread("data/household_power_consumption.txt", na.strings = "?")

## Subset to date range
DT <- DT[as.Date(Date, "%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02"]

# Convert date column
DT$Date <- as.Date(DT$Date, "%d/%m/%Y")

datetime <- paste(as.Date(DT$Date), DT$Time)
DT$DateTime <- as.POSIXct(datetime)

## Add Day column
DT$day <- weekdays(DT$DateTime)

## Subset to only rows of the following days
DaySubSet <-DT[DT$day %in% c("Thursday", "Friday", "Saturday")]

png(file ="plot4.png", width=480, height=480)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(DT$Global_active_power~DT$DateTime, type="l", ylab="Global Active Power", xlab="")
plot(DT$Voltage~DT$DateTime, type="l", ylab="Voltage", xlab="")
plot(DT$Sub_metering_1~DT$DateTime, type="l", ylab="Energy sub metering", xlab="") 
lines(DT$Sub_metering_2~DT$DateTime,col='Red')
lines(DT$Sub_metering_3~DT$DateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(DT$Global_reactive_power~DT$DateTime, type="l", 
     ylab="Global Rective Power",xlab="")
dev.off()