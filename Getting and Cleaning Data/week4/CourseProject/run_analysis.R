## Getting and cleaning Data Course Project

## use the dplyr library
library("dplyr")

## Read the Test Data Set files
testSubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
testXTest <- read.table("UCI HAR Dataset/test/X_test.txt")
testYTest <- read.table("UCI HAR Dataset/test/y_test.txt")


## Read the Training Data Set files
trainSubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainXTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
trainYTrain <- read.table("UCI HAR Dataset/train/y_train.txt")

## bind the subject files together
subject <- rbind(testSubjectTest, trainSubjectTrain)

## rename variable
subject <- rename(subject, subject = V1)

## bind the activity label files together
activityLabels <- rbind(testYTest, trainYTrain)
activityLabels <- rename(activityLabels, activityNumber = V1)

## bind the data files together
data <- rbind(testXTest, trainXTrain)

## Merge subject and activity files
subjectActivity <- cbind(subject, activityLabels)

## Finally, bind data to subject and activity labels
df <- cbind(subjectActivity, data)

## read in the feature file
features <- read.table("UCI HAR Dataset/features.txt")

## extract only the measurements on the mean and standard deviation for each measurement 
features <- features[grepl("mean\\(\\)|std\\(\\)", features[,2]),]

## Add a new column to the features data frame that adds a "V" suffix to the 
## row number to match features in the df data set
featureID <- features[,1]
features <- cbind(features, featureID)
features$featureID <- paste0("V", featureID)

## Subset data by the matching feature ids in the features data frame
df <- df[, which(names(df) %in% c(features$featureID, "subject", "activityNumber"))]

## Add Descriptive activitiy names to name the activities data set

## read in the activities file
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities <- rename(activities, activityNumber = V1, activityDescription = V2)

## Merge data and activities together
df <- merge(df, activities, by="activityNumber", all.x = TRUE)

featureNames <- read.table("UCI HAR Dataset/features.txt")
featureNameID <- featureNames[,1]
featureNames$featureNameID <- paste0("V", featureNameID)

## Add descriptive columns names using feature names values
names(df) <- featureNames$V2[match(names(df), featureNames$featureNameID)]

## reset merged columns names lost in previous step
names(df)[1] <- "activityNumber"
names(df)[2] <- "subject"
names(df)[69] <- "activityDescription"

## Use data.table package and create summary
library(data.table)
summary <- setDT(df)[, lapply(.SD, mean), by = list(subject, activityNumber, activityDescription)]


write.table(summary, "SummaryHumanActivityRecognitionUsingSmartphones.txt", row.names = FALSE)
