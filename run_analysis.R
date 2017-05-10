### check if Directory exists
if (!file.exists("data2")){
  dir.create("data2")
  
}

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

## set URL, Download and unzip data file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data2/watch.zip")

unzip ( "./data2/watch.zip",exdir = "./data2")


## Reading Features table (colums headings)
features<- read.table("./data2/UCI HAR Dataset/features.txt")


## Reading training table
x_train <- read.table("./data2/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data2/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data2/UCI HAR Dataset/train/subject_train.txt")

## Reading Testing table
x_test <- read.table("./data2/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data2/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data2/UCI HAR Dataset/test/subject_test.txt")

## Reading Activitiy table
activityLabels = read.table('./data2/UCI HAR Dataset/activity_labels.txt')


## Add column names to X train and X Test

colnames(x_train) <- features[,2] 
colnames(x_test) <- features[,2]

## Add column names to Y train and Y Test
colnames(y_train) <-"activityId"
colnames(y_test) <-"activityId"

## Add column names to Subject train

colnames(subject_train) <- "subjectId"
colnames(subject_test) <- "subjectId"

## Add column names to Activity Labels
colnames(activityLabels) <- c('activityId','activityType')

## Merge tables together - Colums and then rows
merged_train <- cbind(y_train, subject_train, x_train)
merged_test <- cbind(y_test, subject_test, x_test)

merged_all <- rbind(merged_train,merged_test)

merged_allwithActivitNames <- merge(activityLabels,merged_all,by='activityId', all.x = TRUE)

## Find columns with mean and std

columnnames <-colnames(merged_all)

mean_std_columns <- (grepl("activityId",columnnames) | grepl("subjectId",columnnames) | grepl("mean..", columnnames)|
                       +                      grepl("std..",columnnames))

dsForMeanStd <- merged_allwithActivitNames[,mean_std_columns]

secTidySet <- aggregate(. ~subjectId + activityId, dsForMeanStd, mean)
secTidySetwithNames <- merge(activityLabels,secTidySet,by='activityId', all.x = TRUE)
