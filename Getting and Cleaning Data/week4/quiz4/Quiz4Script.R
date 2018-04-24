## Quiz 4 of getting and cleaning data


## Question 1
setwd("~/Coursera\Data Science\Getting and Cleaning Data\week4\quiz4")
if(!file.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/IdahoHousingData.csv")
data <- read.csv("./data/IdahoHousingData.csv")
splitNames = strsplit(names(data), "wgtp")
splitNames[[123]]

## Question 2
setwd("~/Coursera\Data Science\Getting and Cleaning Data\week4\quiz4")
if(!file.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDP-ranking-table.csv")
data <- data.table(read.csv("data/GDP-ranking-table.csv", skip=4, nrows = 215))
data <- data[X != ""]
data <- data[, list(X, X.1, X.3, X.4)]
setnames(data, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", data[[4]]))
mean(gdp, na.rm = TRUE)

# Question 3
cNames <- data$Long.Name
grep("^United", cNames)

# Question 4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDP-ranking-table.csv")
gdpData <- data.table(read.csv("data/GDP-ranking-table.csv", skip=4, nrows = 215))
gdpData <- gdpData[X != ""]
gdpData <- gdpData[, list(X, X.1, X.3, X.4)]
setnames(gdpData, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                              "Long.Name", "gdp"))

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/FEDStats.csv")
fedData <- data.table(read.csv("data/FEDStats.csv"))

## Merge the data sets
dt <- merge(gdpData, fedData, all = TRUE, by="CountryCode")

isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)
dt[isFiscalYearEnd & isJune, Special.Notes]


# Question 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)