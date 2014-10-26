
## R script for Coursera Getting and Cleaning Data - Course Project
## This script performs the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Date: 26/10/2014 

library("data.table")
library("reshape2")

## Read the features file 
Features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract measurements on the mean and standard deviation for each measurement
EFeatures <- grepl("mean|std", Features)

## Read activity labels file
ActivityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

## Read test data
XTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
YTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Read train data
XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
YTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Assign column names using Features
names(XTest)<- Features
names(XTrain)<- Features

## Extract  measurements on the mean and standard deviation for each measurement
XTest<- XTest[,EFeatures]
XTrain<- XTrain[,EFeatures]

## Assign activity labels
YTest[,2] <- ActivityLabels[YTest[,1]]
YTrain[,2]<- ActivityLabels[YTrain[,1]]

## Assign column names 
names(YTest)<- c("ID_Activity", "Desc_Activity")
names(SubjectTest) <- "Subject"
names(YTrain) <- c("ID_Activity", "Desc_Activity")
names(SubjectTrain) <- "Subject"


## Bind data into 1 dataset
tempTest <- cbind(as.data.table(SubjectTest), YTest, XTest)
tempTrain <- cbind(as.data.table(SubjectTrain), YTrain, XTrain)

## Bind test and train datasets into 1
tempData <- rbind(tempTest, tempTrain)

names <- c("Subject", "ID_Activity", "Desc_Activity")
diffNames <- setdiff(colnames(tempData), names)
meltData <- melt(tempData, id = names, measure.vars = diffNames)

## shape into new dataset
myData <- dcast(meltData, Subject + Desc_Activity ~ variable, mean)

write.table(myData, file = "./tidy.txt", row.name=FALSE)