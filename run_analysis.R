#Peer Assignment getting and cleaning data code

#set working directory

#Step 1 - Unziping files
mainDir <- "./getting_cleaning_data"
subDir <- "peerAssignment"

if(!dir.exists(file.path(mainDir, subDir))) {
  dir.create(file.path(mainDir, subDir))
}

setwd(file.path(mainDir, subDir))
getwd()

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")

unzip(zipfile="dataset.zip",exdir="datafolder")
list.dirs("./datafolder")

#Step 2 - Reading in the data
setwd("./datafolder/UCI HAR Dataset/train")
getwd()

#all train data
trainX <- read.table("X_train.txt")
trainY <- read.table("Y_train.txt")
subject_train <- read.table("subject_train.txt")
summary(trainX); head(trainX,2)
dim(trainY); head(trainY,10); table(trainY)
dim(subject_train);head(subject_train,10); table(subject_train)

#all test data
#setwd() to datafolder/UCI HAR Dataset/test
getwd()
testX <- read.table("X_test.txt")
testY <- read.table("Y_test.txt")
subject_test <- read.table("subject_test.txt")
summary(testX); head(testX,2)
dim(testY); head(testY,10); table(testY)
dim(subject_test); head(subject_test,10); table(subject_test)

#features data
#setwd() to datafolder/UCI HAR Dataset
features <- read.table("features.txt")
dim(features); head(features)
names(features)

#activity labels data
activity_labes <- read.table("activity_labels.txt")
dim(activity_labes); head(activity_labes); names(activity_labes)


#Step 3 - Merging train and test sets to create one data set
totalData <- rbind(trainX, testX)

#Step 4 - Renaming merged data with descriptive variable names
names(totalData)
colnames(totalData) <- features$V2

#Step 5 - Extracting only the measurements on the mean and standard deviation for each measurement
namesSelectedData <- grep("std|mean", tolower(names(totalData)))
length(namesSelectedData)
selectedData <- totalData[,namesSelectedData]
names(selectedData)

#Step 6 - Using descriptive activity names to name the activities in the selected measurement (mean, std) dataset
totalLabels1 <- rbind(trainY, testY)
head(totalLabels1); names(totalLabels1)

totalLabels1$activityLabels <- factor(totalLabels1$V1, levels=c(1,2,3,4,5,6), 
                                      labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING",
                                               "STANDING","LAYING"))

selectedLabeledData <- cbind(totalLabels1,selectedData)
head(selectedLabeledData)


#Step 7 - Adding subject IDs to selected dataset
totalSubject <- rbind(subject_train, subject_test)
head(totalSubject)
colnames(totalSubject) <- c("SubjectID")

finalData <- cbind(totalSubject,selectedLabeledData[,-c(1)])
head(finalData)
names(finalData)


#saving new merged data
write.table(finalData, file="merged_total_data.txt", row.names = FALSE)

#Step 8 - Creating independent tidy data set with the average of each variable for each activity and each subject
library(stats)
any(is.na(finalData))
aggregatedData <-aggregate(finalData, by=list(finalData$SubjectID,finalData$activityLabels), 
                           FUN=mean)
head(aggregatedData, 10)

#removing subject ID and activity labels columns to avoid duplication and renaming added aggregation columns
aggregatedData <- aggregatedData[, -c(3,4)]
colnames(aggregatedData)[1:2] <- c("SubjectID", "activityLabels")

#saving new aggregated data
write.table(aggregatedData, file="means_total_data.txt", row.names = FALSE)







