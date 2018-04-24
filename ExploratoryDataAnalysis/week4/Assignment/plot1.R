## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("./data/DataForPeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS("./data/DataForPeerAssessment/Source_Classification_Code.rds")

# Subset NEI to the years in (1999, 2002, 2005, 2008)
subNEI <- subset(NEI, year %in% c(1999, 2002, 2005, 2008))

png(file ="plot1.png", width=480, height=480)

barplot(tapply(subNEI$Emissions, subNEI$year, FUN=sum), 
        main="Total Emmissions PM25 in United States",
        xlab="Year", 
        ylab="Emissions")

dev.off()