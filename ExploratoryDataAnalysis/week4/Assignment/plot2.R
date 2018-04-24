## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.

NEI <- readRDS("./data/DataForPeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS("./data/DataForPeerAssessment/Source_Classification_Code.rds")

# Subset NEI to the US county for Baltimore City, Maryland
subNEI <- subset(NEI, fips == 24510) 

png(file ="plot2.png", width=480, height=480)

barplot(tapply(subNEI$Emissions, subNEI$year, FUN=sum), 
        main="Emissions in Baltimore City, Maryland",
        xlab="Year", 
        ylab="Emissions")

dev.off()