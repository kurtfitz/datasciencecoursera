# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999-2008?

NEI <- readRDS("./data/DataForPeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS("./data/DataForPeerAssessment/Source_Classification_Code.rds")
library(ggplot2)

# merge the data sets
NEISCC <- merge(NEI, SCC, by="SCC")

# Find the short names that contain 'vehicle'
vehicleSubset <- grepl("vehicles", NEISCC$EI.Sector, ignore.case=TRUE)
vehicleSubsetNEISCC <- NEISCC[vehicleSubset, ]

# 24510 is for Baltimore City Maryland, #06037 Los Angles County
vehicleSubsetNEISCC <- vehicleSubsetNEISCC[vehicleSubsetNEISCC$fips %in% c("24510","06037"), ]

totalsByYear <- aggregate(Emissions ~ year + fips, vehicleSubsetNEISCC, sum)
totalsByYear$fips[totalsByYear$fips=="24510"] <- "Baltimore, MD"
totalsByYear$fips[totalsByYear$fips=="06037"] <- "Los Angeles, CA"

png(file ="plot6.png", width=480, height=480)

g <- ggplot(totalsByYear, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_col()  +
  xlab("year") +
  ylab("Total PM25 Emiisions") +
  ggtitle('Total Emissions from vehicle sources from 1999 to 2008')
print(g)

dev.off()