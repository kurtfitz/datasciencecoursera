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

# 24510 is for Baltimore City Maryland
vehicleSubsetNEISCC  <- NEI[vehicleSubsetNEISCC$fips=="24510", ]

totalsByYear <- aggregate(Emissions ~ year, vehicleSubsetNEISCC, sum)

png(file ="plot5.png", width=480, height=480)

g <- ggplot(totalsByYear, aes(factor(year), Emissions))
g <- g + geom_col() +
  xlab("year") +
  ylab("Total PM25 Emiisions") +
  ggtitle('Total Emissions from vehicle sources from 1999 to 2008')
print(g)

dev.off()