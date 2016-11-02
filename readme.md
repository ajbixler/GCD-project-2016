#README.MD
Source data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data from UCI machine learning project has several folders and files. 
The UCI data shows both unprocessed data from sensors and calculated data based on the raw sensor input.
This script reads in the column names from features.txt and parses them to find the data variables reqired for the project - only the ones that show mean and standard deviation values for a calculated property (or feature).
The data sets are read in from X_test.txt and X_train.txt and are combined in that order.
Column names are assigned.
Additional columns are written to: 
    indicate whether the observaiton comes from the test or train data sets
    show the activity involved -INCOMPLETE-
    show the participant ID -INCOMPLETE
Data are averaged for each participant and activity combination are averaged together -INCOMPLETE
Finally the file is written


The complete list of variables of each feature vector is available in 'codebook.md'
