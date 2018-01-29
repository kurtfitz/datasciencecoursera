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
data <- read.csv("./data/GDP-ranking-table.csv)