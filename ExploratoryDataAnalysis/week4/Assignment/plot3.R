# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
# Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 
# plotting system to make a plot answer this question.

NEI <- readRDS("./data/DataForPeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS("./data/DataForPeerAssessment/summarySCC_PM25.rds")

library(ggplot2)

# 24510 is for Baltimore City Maryland
baltNEI  <- NEI[NEI$fips=="24510", ]

totalByYearAndType <- aggregate(Emissions ~ year + type, baltNEI, sum)

png(file ="plot3.png", width=480, height=480)

g <- ggplot(totalByYearAndType, aes(year, Emissions, color = type))

g <- g + geom_line() +
  xlab("year") +
  ylab("Total PM2.5 Emissions") +
  ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')
print(g)
dev.off()