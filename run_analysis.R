#You should create one R script called run_analysis.R that does the following.

#1-Merges the training and the test sets to create one data set.
#2-Extracts only the measurements on the mean and standard deviation for each measurement.
#3-Uses descriptive activity names to name the activities in the data set
#4-Appropriately labels the data set with descriptive variable names.
#5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# UCI website (codebook): http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data")){dir.create("./data")}
download.file(url, destfile = "./data/UCIdata.zip", method = "curl")
unzip("./data/UCIdata.zip", exdir = "./data")

# test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
# head(test) #128 col x 2947 rows, col names V1 - V128


#from readme, other txt files, deterimed the following
#raw measued data is in inertial signals subfolder, and can be ignored here
#main data is in X_test and X_train
#column names for X_test and X_train are in features.txt
#subject_test.txt has subject ID for each row.  need to glom this onto our data
#y_test.txt tells which of 6 activities was being done for each row measurement- ignore? convert to variable?

xcolnames <- read.table("./data/UCI HAR Dataset/features.txt")
xcolnames <- as.character(xcolnames$V2)
xcolmean <- grepl("ean", xcolnames)
xcolstd <- grepl("std", xcolnames)
xcolselect <- xcolmean+xcolstd #These are the columns we want
xcolselectwset<- c(xcolselect, TRUE)
xcolsub <- subset(xcolnames, xcolselect == TRUE) #these are the lables for just those columns

#read in data, assign names, merge, and glom on set column
Xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

Xcombined <- rbind(Xtest,Xtrain)
Xcombinedsub <- Xcombined[,xcolselect]
colnames(Xcombinedsub)<-(xcolsub)

#gives a df with selected variables (86 columns), named based on features.txt
#df has rows from test set at top, followed by rows from train set

#add column indicating test or train set
test<-rep("test", nrow(Xtest))
train<-rep("train",nrow(Xtrain))
Xcombinedsub<-mutate(Xcombinedsub, set=c(test,train))

#add a column for activity
#add a column for participant
#average all rows for a given participant and activity
#convert activity code to human readable

#write data to table
write.table(Xcombinedsub, "./data/ABtidyOutput1.txt", row.names = FALSE)
