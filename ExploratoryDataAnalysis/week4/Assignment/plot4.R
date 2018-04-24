# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999-2008?

NEI <- readRDS("./data/DataForPeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS("./data/DataForPeerAssessment/Source_Classification_Code.rds")
library(ggplot2)

NEISCC <- merge(NEI, SCC, by="SCC")

# Find the short names that contain 'coal'
coalSub  <- grepl("coal", NEISCC$EI.Sector, ignore.case=TRUE)
coalSubNEISCC <- NEISCC[coalSub, ]

totalsByYear <- aggregate(Emissions ~ year, coalSubNEISCC, sum)

png(file ="plot4.png", width=480, height=480)

g <- ggplot(totalsByYear, aes(factor(year), Emissions))
g <- g + geom_col() +
  xlab("year") +
  ylab("Total PM25 Emiisions") +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)

dev.off()