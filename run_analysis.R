## Script for Coursera Getting and Cleaning Data course project 
#  
# This script works as follows: 
#  1. Checks environment for existence of variables with raw data.
#  2. If they not yet loaded, script reads appropriate files. If necessary, downloads them from internet.
#  3. Merges test and train data sets.
#  4. Assigns descriptive names to every column(provided by 'features.txt')
#  5. Extracts only the measurements on the mean and standard deviation for each measurement.
#  5. Lables activities by names using 'activity_labels.txt' 
#  6. Merges all data together
#  7. Creates new tidy data frame with average of each variable for each activity and each subject.
#  8. Writes results to files for each activity and each subject.
# 
# Author:         matyas.theuer@gmail.com 
# Last edit:      22.1.2015      

library(dplyr)

# Check if variables are already loaded
expectedVars <- c("test.subject","test.x","test.y","train.subject","train.x","train.y")

# If not, read them
if (!all(expectedVars %in% ls())){
      
      # Check for presence of folder with data
      if (!file.exists("UCI HAR Dataset")) {
            message("Downloading data...")
            fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            download.file(fileURL, destfile="./UCI_HAR_data.zip", method="auto")
            unzip("UCI_HAR_data.zip")
      }
      # Read data form files
      message("Reading data...")
      train.x <- read.table("UCI HAR Dataset/train/X_train.txt")
      train.y <- read.table("UCI HAR Dataset/train/y_train.txt")
      train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
      test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
      test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
      test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
}

# Merge data sets
message("Cleaning data...")
data.x <- rbind(train.x, test.x)
data.y <- rbind(train.y, test.y) 
data.subject <- rbind(train.subject, test.subject)
colnames(data.y) <- c("activity")
colnames(data.subject) <- c("subject")

# extract only mean and std columns for x
features <- read.table("UCI HAR Dataset/features.txt")
colnames(data.x) <- features$V2
meanColumns <- grepl("mean()", features$V2,fixed=T)
stdColumns <- grepl("std()", features$V2,fixed=T)
data.x <- data.x[meanColumns|stdColumns]

# identify labels for y
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
labels$V2 <- tolower(labels$V2)
data.y <- mutate(data.y, activity = labels$V2[activity])

# merge all data together
data <- cbind(data.subject,data.y,data.x)

# get average of each variable for each activity and each subject
tidy.data <- data %>% group_by(subject,activity) %>% summarise_each(funs(mean))

# write results
message("Writing results...")
write.table(data, "UCI_HAR_data.txt", row.names=FALSE)
write.table(tidy.data, "UCI_HAR_tidy_data.txt", row.names=FALSE)
message("All done.")
