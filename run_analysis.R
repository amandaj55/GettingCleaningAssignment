
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_HAR_dataset.zip")
unzip("UCI_HAR_dataset.zip")
setwd("UCI HAR Dataset")
activityLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
setwd("test/")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
subjecttest <- read.table("subject_test.txt")
setwd("~/Documents/Coursera/GettingCleaningData/Assignment/data/UCI HAR Dataset")
library(dplyr)
## rename(ytest, activity = V1)
## or
names(ytest)[names(ytest)=="V1"] <- "activity"
names(subjecttest)[names(subjecttest)=="V1"] <- "subject"
test <- cbind(ytest, xtest)
testall <- cbind(subjecttest, test)
testall$set <- "test"

setwd("train/")
xtrain <- read.table("x_train.txt")
ytrain <- read.table("y_train.txt")
subjecttrain <- read.table("subject_train.txt")
ytrain <- rename(ytrain, activity = V1)
## or
## names(ytrain)[names(ytrain)=="V1"] <- "activity"
subjecttrain <- rename(subjecttrain, subject = V1)
## or
## names(subjecttrain)[names(subjecttrain)=="V1"] <- "subject"
train <- cbind(ytrain, xtrain)
trainall <- cbind(subjecttrain,train)
trainall$set <- "train"

## merge training and test sets
testtrain <- rbind(testall,trainall)
testtrain <- testtrain[,c(564,1:563)]
newnames <- features[1:561,2]
newnames<-gsub("\\)","",newnames)
newnames<-gsub("\\(","",newnames)
newnames<-gsub("-","",newnames)
newnames<-gsub(",","",newnames)
newnames<-gsub("\"","",newnames)
names(testtrain)<- c("set", "subject", "activity", newnames)
## extract measurements of mean and standard deviation
testtrainMeanStd <- testtrain[,grepl("Mean|mean|std|Std|set|activity|subject", colnames(testtrain))]
## change activity labels
testtrainMeanStd$activity[testtrainMean1$activity==1] <- "walking"
testtrainMeanStd$activity[testtrainMean1$activity==2] <- "walkingUpstairs"
testtrainMeanStd$activity[testtrainMean1$activity==3] <- "walkingDownstairs"
testtrainMeanStd$activity[testtrainMean1$activity==4] <- "sitting"
testtrainMeanStd$activity[testtrainMean1$activity==5] <- "standing"
testtrainMeanStd$activity[testtrainMean1$activity==6] <- "laying"
## label some of data set with descriptive variable names - unfinished
testtrainMeanStd <- rename(testtrainMeanStd, MeanBodyAccelerationX = tBodyAccmeanX)
testtrainMeanStd <- rename(testtrainMeanStd, MeanBodyAccelerationY = tBodyAccmeanY)
testtrainMeanStd <- rename(testtrainMeanStd, MeanBodyAccelerationZ = tBodyAccmeanZ)
testtrainMeanStd <- rename(testtrainMeanStd, StdDevBodyAccelerationX = tBodyAccstdX)
testtrainMeanStd <- rename(testtrainMeanStd, StdDevBodyAccelerationY = tBodyAccstdY)
testtrainMeanStd <- rename(testtrainMeanStd, StdDevBodyAccelerationZ = tBodyAccstdZ)
## group by activity and subject and calculate average of each variable in new data set
aggtesttrain <-aggregate(testtrainMeanStd[4:89], by=list(testtrainMeanStd$subject,testtrainMeanStd$activity), FUN=mean, na.rm=TRUE)
## rename group by variables to activity and subject
aggtesttrain <- rename(aggtesttrain, activity = Group.1)
aggtesttrain <- rename(aggtesttrain, subject = Group.2)
setwd("../")
write.table(aggtesttrain, "AggregatedAccelGyroData.txt",row.name=FALSE)

testtrainMelt <-melt(testtrain, id=c("set","subject","activity"), )