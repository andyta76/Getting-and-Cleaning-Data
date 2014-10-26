#Getting and Cleaning Data


##Course Project

### Project Instructions

Create R script called run_analysis.R that does the following:

+ Merges the training and the test sets to create one data set.
+ Extracts only the measurements on the mean and standard deviation for each measurement.
+ Uses descriptive activity names to name the activities in the data set
+ Appropriately labels the data set with descriptive activity names.
+ Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


### How the script works:

+ Reads the training and test datasets
+ Assigns respective column names to training and test datasets
+ Merges the training and test datasets
+ Generates the "tidied" dataset (tidy.txt)

Note: This script uses reshape2 and data.table libraries.