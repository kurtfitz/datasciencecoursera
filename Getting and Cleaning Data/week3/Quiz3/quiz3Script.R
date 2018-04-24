

## Check for missing values in a column
## sum(is.na(data$x))
## Handy function for getting a summmary of the missing values in a data set
## colSums(is.na(data))
## Another handy function for telling whether there are ANY missing values in a data set
## all(colSums(is.na(data)) == 0)

## Subsetting data values with specific characteristics
## data[data$zipCode %in% c("21212", "21213"),]

## Returns the Idaho housing data read into memory
getIdahoHousingData <- function() {
  setwd("~/Coursera\Data Science\Getting and Cleaning Data\week3\Quiz3")
  if(!file.exists("./data")) {
    dir.create("./data")
  }
  
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile = "./data/IdahoHousingData.csv")
  data <- read.csv("./data/IdahoHousingData.csv")
}


## Question 2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
setwd("~/Coursera\Data Science\Getting and Cleaning Data\week3\Quiz3")
download.file(url, "jeff.jpg", mode = "wb")
img <- readJPEG("jeff.jpg", native = TRUE)
quantile(img, probs = c(0.3, 0.8))

## Quesiton 3
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
setwd("~/Coursera\Data Science\Getting and Cleaning Data\week3\Quiz3")
download.file(url1, "GDP190.csv")
download.file(url2, "FEDSTATS_Country.csv")
dtGDP <- data.table(read.csv("GDP190.csv", skip = 4))
dtGDP[,c("X.5", "X.6", "X.7", "X.8"):=NULL] ## remove empty columns
dtGDP <- dtGDP[X != ""] #remove rows with empty value for country code
dtGDP <- dtGDP[X.1 != ""] #remove rows with empty value for GDP ranking
dtEd <- data.table(read.csv("FEDSTATS_Country.csv"))

dt <- merge(dtGDP, dtEd, by.x="X", by.y="CountryCode", all = TRUE)


