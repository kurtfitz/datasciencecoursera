## Week 1 Course Project File

## Use the data.table library and fread for better performance
library(data.table)

## Because this is a large data set and we only need rows between a 
## certain date range (2007-02-01 and 2007-02-02.), we can subset the 
## file that is loaded in memory
DT <- fread("data/household_power_consumption.txt")
DT <- DT[as.Date(Date, "%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02"]

## Our overall goal here is simply to examine how household energy usage varies over a 2-day 
## period in February, 2007

