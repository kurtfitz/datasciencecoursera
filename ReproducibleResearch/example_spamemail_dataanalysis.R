## Example of doing some exploratory Data Analysis on kern spam email data

# If it isn't installed, install the kernlab package
library(kernlab)
data(spam)

# Perform the subsampling

# The first thing we need to do if we want to build a model for classifying
# email as spam or not, is to first split the data into a test set
# and a training set. 
# First we will use part of the data set to build our model
# Second we will use another part of the data set, that is independant of the first
# to determine how good our model is at making the prediction.

set.seed(3435)

# Here we are taking a random half of the data set: "flipping a coin with the 
# rbinom function. We generate a random coin flip with a probability of 1/2
# to seperate the data into two pieces.
trainIndicator = rbinom(4601, size=1, prob=0.5)

# This prints out how many observations are each in half of the data
table(trainIndicator)

# Seperate the training and test data
# Our Exploratory data analyses is done on our training data set
trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

# First thing we want to do is a bit of Exploratory data analysis
# Look at summaries of the data
# Check for missing data
# Create exploratory plots
# Perform exploratory analyses (e.g. clustering)

# Questions to be thinking about
# What do the data look like? 
# What is the distribution of the data?
# What are the relationships between the variables?
# Is there any missing data? If so, why?

names(trainSpam)
# we see frequency counts of words within emails

# in the training set, lets see how many are classified as spam
table(trainSpam$type)

# Make some plots (here the avg number of capital letters)
plot(trainSpam$capitalAve ~ trainSpam$type)

# Look at pair wise relationship between different variables
# ??? Not sure what this output really means?
# Shows correlations between some of the variables in the data set
plot(log10(trainSpam[, 1:4] + 1))

# Heirarchical Cluster Analysis
hCluster = hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)
# You'll notice it's not that useful at this point
# recall that clustering algorithms can be sensitive to any skewness (curve appears
# distorted to the left or right) in the distribution
# In cases like this it may be useful to do a cluster analysis after a 
# transformation of the cluster space

# take a base 10 log transformation of the training data (we're adding one 
# here to each to avoid taking the log of 0 )
hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)

## STATISTICAL PREDICTION/MODELING
# Once you've completed the exploratory analyis above, some univariate and bivariate
# plots, and some cluster analysis. We can move one to the more sophisticated 
# prediction/statistical modeling. 
# This should be informed by the following:
# - The reuslts of the exploratory analysis
# - Exact methods depend on the question of interest
# - Transformations/processing should be accounted for when necessary
# - Think of the measures/sources of uncertainty


trainSpam$numType = as.numeric(trainSpam$type) - 1
constFunction = function(x, y)  sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for (i in 1:55) {
  lmFormula = reformulate(names(trainSpam)[i], response = "numType")
  glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
  cvError[i] = cv.glm(trainSpam, glmFit, constFunction, 2)$delta[2]
}

# Which predictor has minimum cross-validator error?
names(trainSpam)[which.min(cvError)]

## Use the best model from the group
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)

## Get predictions on the test set
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonspam", dim(testSpam)[1])

## Classify as 'spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"

## Classification table
table(predictedSpam, testSpam$type)

## Error rate
(61 + 458)/(1346 + 458 + 61 + 449)



## INTERPRET RESULTS


## CHALLANGE RESULTS


## SYNTHESIZE/WRITE-UP RESULTS
# - leave with question
# - summarize the analyses into the story
# - Don't include everyhting in analyses
# - include pretty figures that contribute to the story


# In the Example
# Can I use quantitative characteristics of emails to classify them as SPAM/HAM
# Describe the approach
# - Collected data from UCI -> created train/test sets
# - Explored relationships
# - Chose logistic model on training set by cross validation (READ MORE ABOUT THIS)
# - Applied to test, 78% test set accuracy

# Interpret results
# - Number of dollar sign seems reasonable, e.g. "Make money with Viagra $ $ $ $!"
# Challange results
# - 78% isn't that great
# - I could use more variables
# - Why logistic regression

