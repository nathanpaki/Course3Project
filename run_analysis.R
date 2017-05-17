##  run_analysis.R
## Written by Nathan Pakianathan
## For Coursera Getting and Cleaning Data Project Assignment Week 4
## Written and submitted on May 10, 2017


# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# 
# Review criteria
# 
# The submitted data set is tidy.
# The Github repo contains the required scripts.
# GitHub contains a code book that modifies and updates the available 
#    codebooks with the data to indicate all the variables and summaries calculated, 
#    along with units, and any other relevant information.
# The README that explains the analysis files is clear and understandable.

## Check to see needed packages are installed
## dplyr
if (!"dplyr" %in% installed.packages()) {
  warning("dplyr required for this script. Installing dplyr.")
  install.packages("dplyr")
}

## data.table
if (!"data.table" %in% installed.packages()) {
  warning("data.table required for this script. Installing data.table.")
  install.packages("data.table")
}

## Call both libraries.

library(dplyr)
library(data.table)

### check if Directory exists
if (!file.exists("data2")){
  dir.create("data2")
  
}


## set URL, Download and unzip data file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data2/watch.zip")

## Unzip files

unzip ( "./data2/watch.zip",exdir = "./data2")

## Reading Features table (colums headings)
features<- read.table("./data2/UCI HAR Dataset/features.txt")

## Reading training table
xtrain <- read.table("./data2/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data2/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data2/UCI HAR Dataset/train/subject_train.txt")


## Reading Testing table
xtest <- read.table("./data2/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data2/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data2/UCI HAR Dataset/test/subject_test.txt")

## Reading Activitiy table
activityLabels = read.table('./data2/UCI HAR Dataset/activity_labels.txt')

## Adding column labels is done below

## Add column names to x_train and x_test

colnames(xtrain) <- features[,2] 
colnames(xtest) <- features[,2]

## Add column names to y_train and y_test

colnames(ytrain) <-"activityId"
colnames(ytest) <-"activityId"

## Add column names to Subject_train and subject_test

colnames(subject_train) <- "subjectId"
colnames(subject_test) <- "subjectId"


## Add column names to Activity Labels
colnames(activityLabels) <- c('activityId','activityType')


## Merge tables together - Colums and then rows
## Columns
mergedtrain <- cbind( subject_train, ytrain, xtrain)
mergedtest <- cbind( subject_test,ytest, xtest)

## Rows are merged here from Training and Testing data.
##This is a complete set of data

mergedall <- rbind(mergedtrain,mergedtest)

## Get column names from mergedall dataset which has Mean and std. Also keep the activityLabels, subjectID

columnnames <-colnames(mergedall)
meanstdcolumns <- (grepl("activityId",columnnames) | grepl("subjectId",columnnames) | grepl("mean..", columnnames)|
                                             grepl("std..",columnnames))





dsForMeanStd <- mergedall[,meanstdcolumns]

tidyset <- aggregate(. ~activityId + subjectId, dsForMeanStd, mean)
tidyset <- merge(activityLabels,tidyset,by='activityId', all.x = TRUE)


## write the result to a text file
write.table(tidyset,file="tidydata.txt",row.names = FALSE)




