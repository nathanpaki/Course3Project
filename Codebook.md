---
title: "Cookbook.md"
author: "Nathan Pakianathan"
date: "May 17, 2017"
output: html_document
---


## Codebook for Getting and Cleaning Data

# Overview

The codebook is for the datafile tidydata.txt created as part of the course requirement for Getting and Cleaning Data Week 4 Project.

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

An R script called run_analysis.R is to be created that does the following.

Merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set Appropriately labels the data set with descriptive variable names. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Table names

Table Name  | Table contents
------------ | -------------
xtrain   | Training Dataset of X
ytrain   | Training Dataset of y
xtest   | Test Dataset of X
ytest   | Test Dataset of y
features   | Training Dataset of Features
subject_test   | Dataset of subjects for testing
subject_train   | Dataset of subjects for training
activityLabels | Activity Labels

### Variable Names

Variable Name  | Description
------------ | -------------
mergedtrain   | xtrain and ytrain tables merged (columns)
mergedtest   | xtest and ytest tables merged (columns)
mergedall   | mergedtrain and merged test tables merged (rows)
columnnames  | Column names from mergedall
meanstdcolums | Columns that has means and stds
dsForMeanStd | dataset with mean and std columns only
tidyset  | Tidyset
tidydata.txt | the date file written 


### Steps taken to accomplish
1. Make sure the libraries and director exists.
1. Set the URL
1. Download the required file unzip
1. Read the data files and assing to datasets
1. Add column labels
1. Merge datasets to form one large dataset
1. Eliminate rows that are not needed.
1. Summarize and calculate mean and create a tidy file
1. Write tidyfile to a txt file