

# need to use the methods melt and  dcast and hence need to make sure we have reshape2
if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
# load the library
library("reshape2")


# set the file names and the data directory 
fileName <- "./data/Dataset.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download the file 
if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb") 
}

print("zip file is downloaded")

# Unzip the file
unzip(fileName, files = NULL, exdir=".")
print("zip file is unzipped")


## Now READ all the files as data frames
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
print("All the files are read")

# 1. Merges the training and the test sets for the X to create one data set.
# use row bind
measurements <- rbind(X_train,X_test)

# 2. Extracts only the mean and standard deviation for each measurement. 
# Skip the first column in the Features and just get the indices of the rows in the 2nd column that contains the mean or standard deviation
# store then as list
Mean_Std  <- grep("mean()|std()", features[, 2]) 
measurements <- measurements[,Mean_Std]
print("Measurement data sets only include the ones that have mean or standard deviation")

# 3. Uses descriptive activity names to name the activities in the data set
#get all the activities by doing a row bind
activity <- rbind(y_train, y_test)
names(activity_labels) <- c('act_id', 'act_name')
activity[, 1] = activity_labels[activity[, 1], 2]
names(activity) <- 'activity'
print("All the activities are named")

# 4. Appropriately labels the data set with descriptive activity names.
# Create feature names list by removing "()" apply to the measurements to rename labels.gsub does a global substitute
featureNames <- gsub("[()]", "", features[, 2])
names(measurements) <- featureNames[Mean_Std]
print("name the measurements")


# combine test and train of subject data
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'



# combine subject, activity, and mean and std only data set to create ready go go measurements.
measurements <- cbind(subject,activity, measurements)

print("get the measurements")



# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#create a molten data frame and then get the mean of the measurements using dcast and finally write a tidy data file
moltenData <- melt(measurements,(id.vars=c("subject","activity")))
tidyDataset <- dcast(moltenData, subject + activity ~ variable, mean)
write.table(tidyDataset, "tidy_data.txt", sep = ",")
print("tidy data file is written")


