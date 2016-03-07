## Getting and Cleaning Data Course Assignment

## get datasets

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_HAR_dataset.zip")
unzip("UCI_HAR_dataset.zip")
setwd("UCI HAR Dataset")

## read files into r
activityLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
setwd("test/")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
subjecttest <- read.table("subject_test.txt")
setwd("../")
library(dplyr)

## rename activity and subject variables in y and subject files
ytest <- rename(ytest, activity = V1)
subjecttest <- rename(subjecttest, subject = V1)

## combine y and xtest files to test
test <- cbind(ytest, xtest)
## combine subjecttest and test files to testall
testall <- cbind(subjecttest, test)

## add set variable = test
testall$set <- "test"

## move to train dir
setwd("train/")
## read in train files to r
xtrain <- read.table("x_train.txt")
ytrain <- read.table("y_train.txt")
subjecttrain <- read.table("subject_train.txt")
## rename ytrain and subjecttrain vars
ytrain <- rename(ytrain, activity = V1)
subjecttrain <- rename(subjecttrain, subject = V1)
## combine y and xtrain files to train
train <- cbind(ytrain, xtrain)
## combine subjecttrain and train files to trainall
trainall <- cbind(subjecttrain,train)
## add set variable = train
trainall$set <- "train"

## merge training and test sets
testtrain <- rbind(testall,trainall)
## reoreder testtrain so set var is 1st
testtrain <- testtrain[,c(564,1:563)]
## read in feature names of measurement variables and clean
newnames <- features[1:561,2]
newnames<-gsub("\\)","",newnames)
newnames<-gsub("\\(","",newnames)
newnames<-gsub("-","",newnames)
newnames<-gsub(",","",newnames)
## rename var names in testtrain to feature names of measurement vars
names(testtrain)<- c("set", "subject", "activity", newnames)
## extract measurements of mean and standard deviation
testtrainMeanStd <- testtrain[,grepl("Mean|mean|std|Std|set|activity|subject", colnames(testtrain))]
## change activity labels
testtrainMeanStd$activity[testtrainMeanStd$activity==1] <- "walking"
testtrainMeanStd$activity[testtrainMeanStd$activity==2] <- "walkingUpstairs"
testtrainMeanStd$activity[testtrainMeanStd$activity==3] <- "walkingDownstairs"
testtrainMeanStd$activity[testtrainMeanStd$activity==4] <- "sitting"
testtrainMeanStd$activity[testtrainMeanStd$activity==5] <- "standing"
testtrainMeanStd$activity[testtrainMeanStd$activity==6] <- "laying"
## label some of data set with descriptive variable names
testtrainMeanStd <- rename(testtrainMeanStd, MeanBodyAccelerationX = tBodyAccmeanX)
testtrainMeanStd <- rename(testtrainMeanStd, MeanBodyAccelerationY = tBodyAccmeanY)
testtrainMeanStd <- rename(testtrainMeanStd, MeanBodyAccelerationZ = tBodyAccmeanZ)
testtrainMeanStd <- rename(testtrainMeanStd, StdDevBodyAccelerationX = tBodyAccstdX)
testtrainMeanStd <- rename(testtrainMeanStd, StdDevBodyAccelerationY = tBodyAccstdY)
testtrainMeanStd <- rename(testtrainMeanStd, StdDevBodyAccelerationZ = tBodyAccstdZ)

## group by activity and subject and calculate average of each variable in new data set
aggtesttrain <-aggregate(testtrainMeanStd[4:89], by=list(testtrainMeanStd$subject,testtrainMeanStd$activity), mean, na.rm=TRUE)
## rename group by variables to activity and subject
aggtesttrain <- rename(aggtesttrain, subject = Group.1)
aggtesttrain <- rename(aggtesttrain, activity = Group.2)
setwd("../")
write.table(aggtesttrain, "AggregatedAccelGyroData.txt",row.name=FALSE)
