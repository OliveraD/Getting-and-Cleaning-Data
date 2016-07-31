#Getting and Cleaning Data Course Project

This file describes how to reproduce getting and cleaning of the data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description of *Human Activity Recognition Using Smartphones Data Set* is available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R  script should be run in the working directory. 
The run_analysis.R script includes: 

* Step 1 - Unziping files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Step 2 - Reading in the data (all train and test data, features, and activity labels data)

* Step 3 - Merging train and test sets to create single data set

* Step 4 - Renaming merged data with descriptive variable names

* Step 5 - Extracting only the measurements on the mean and standard deviation for each measurement

* Step 6 - Using descriptive activity names to name the activities in the selected measurement (mean, std) dataset

* Step 7 - Adding subject IDs to selected dataset and saving new merged data

* Step 8 - Creating independent tidy data set with the average of each variable for each activity and each subject and saving new aggregated data


Running run_analysis.R  script generates two output files in the UCI HAR Dataset directory:

1. merged_total_data.txt

2. means_total_data.txt

Both output files are included into this Github repo. This Github repo also includes a code book describing the variables, the data, and all transformations performed to clean up and prepare tidy data called CodeBook.md.