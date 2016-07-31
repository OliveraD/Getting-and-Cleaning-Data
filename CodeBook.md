
#Getting and Cleaning Data Course Project CodeBook
This file describes the variables, the data, and all transformations performed to clean up and prepare tidy data for Getting and Cleaning Data Course Project.

####The site where the data can be obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

####The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

####The run_analysis.R script includes the following steps and transformations to clean up and prepare tidy data:

1. Step 1 - Unziping files: defining names of main and sub directories where zipped original data will be downloaded; main and sub directories names are based on the course and peer assignment names and stored in *mainDir* and *subDir* variables respectively 
2. Step 1 - Unziping files: checking for existence of main and sub directories and creating them if they do not exist
3. Step 1 - Unziping files: setting work directory
4. Step 1 - Unziping files: downloading the project data by storing a link in *url* variable and naming a destination folder *dataset.zip* 
5. Step 1 - Unziping files: unzipping files into *datafolder* directory
6. Step 2 - Reading in the data: Read X_train.txt, y_train.txt and subject_train.txt from the "./datafolder/UCI HAR Dataset/train" folder and store them in *trainX*, *trainY* and *subject_train* variables respectively
7. Step 2 - Reading in the data: Read X_test.txt, y_test.txt and subject_test.txt from the "./datafolder/UCI HAR Dataset/test" folder and store them in *testX*, *testY* and *subject_test* variables respectively
8. Step 2 - Reading in the data: Read features.txt from "./datafolder/UCI HAR Dataset" and store them in *features* variable
9. Step 2 - Reading in the data: Read activity_labels.txt from "./datafolder/UCI HAR Dataset" and store them in *activity_labels* data set
10. Step 3 - Merging train and test sets to create one data set: Concatenate *trainX* to *testX* data to generate merged 10299x561 data frame *totalData*
11. Step 4 - Renaming merged data with descriptive variable names: Rename column names in *totalData* data frame with variable 2 values from *features* data frame. This results in renaming of 561 variables in *totalData*
12. Step 5 - Extracting only the measurements on the mean and standard deviation for each measurement: Extract the measurements on the mean and standard deviation from names of *totalData* data frame variables (edited to lower cases) and store them in *namesSelectedData* variable. This results in the 86 indices list. *namesSelectedData* variable is then used to subset *totalData* and extract only variables containing mean and standard deviation in their names (86 columns)
13. Step 6 - Using descriptive activity names to name the activities in the selected measurement (mean, std) dataset: Concatenate *trainY* to *testY* data to generate merged data frame *totalLabels1*
14. Step 6 - Using descriptive activity names to name the activities in the selected measurement (mean, std) dataset: Create new factor variable in *totalLabels1* data frame named *activityLabels* with 6 levels labeled with activity names (based on *activity_labels* data set)
15. Step 6 - Using descriptive activity names to name the activities in the selected measurement (mean, std) dataset: Combine *totalLabels1* and *selectedData* data frames to assign descriptive names to activities in the selected measurement (mean, std) dataset and store this data frame as *selectedLabeledData*
16. Step 7 - Adding subject IDs to selected dataset: Concatenate *subject_train* to *subject_test* data to generate merged 10299x1 data frame *totalSubject*. Then rename v1 variable of the *totalSubject* data frame into *SubjectID*
17. Step 7 - Adding subject IDs to selected dataset: Combine the *totalSubject* and *selectedLabeledData* removing variable 1 from the former thus removing activities in the form of indices, and leaving only activities names. Store this in the new cleaned 10299x88 data frame *finalData*
18. Step 7 - Adding subject IDs to selected dataset: Save new merged data in the file *"merged_total_data.txt"*
19. Step 8 - Creating independent tidy data set with the average of each variable for each activity and each subject: Generate a second independent tidy data set with the average of each measurement for each activity and each subject. With the 30 unique subjects and 6 unique activities we can have 180 possible combinations (of the subjects and activities) and corresponding means of each measurement. We use *aggregate* function from *stats* package (we assign subject ID and activity labels to the argument *by* and mean to the argument *FUN*).  Obtained data set is stored in the *aggregateData* object
20. Step 8 - Creating independent tidy data set with the average of each variable for each activity and each subject: Save new aggregated data set in  *"means_total_data.txt"* file in current working directory
