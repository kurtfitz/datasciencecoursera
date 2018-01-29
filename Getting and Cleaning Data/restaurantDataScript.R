## Getting and Cleaning Data Week 3 Notes
##  Note you have to make sure your working directory is set correctly

baltimoreRestaurants <- function() {
  setwd("~/Coursera/Data Science/Getting and Cleaning Data")
  if(!file.exists("./data")) {
    dir.create("./data")
  }
  
  fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
  download.file(fileUrl, destfile = "./data/restaurants.csv")
  restData <- read.csv("./data/restaurants.csv")
}

## A little review and some valuable functions
# head and tail and viewing partial data
# summary(data) - outputs 


