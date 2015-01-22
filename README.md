Coursera Getting and Cleaning Data Course Project
=================================================

*This is a CodeBook for my course project.* 

Purpose of this program is to prepare a clean dataset from provided raw data from accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
 
Data can be downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and placed to working directory or the script will do this for you.

For running the program just run "run_analysis.R"
  
This script works as follows: 
 1. Checks environment for existence of variables with raw data.
 2. If they not yet loaded, script reads appropriate files. If necessary, downloads them from internet.
 3. Merges test and train data sets.
 4. Assigns descriptive names to every column(provided by 'features.txt')
 5. Extracts only the measurements on the mean and standard deviation for each measurement.
 5. Lables activities by names using 'activity_labels.txt' 
 6. Merges all data together
 7. Creates new tidy data frame with average of each variable for each activity and each subject.
 8. Writes results to files



Author:         matyas.theuer@gmail.com 
Last edit:      22.1.2015      