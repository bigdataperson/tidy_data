High Level
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive activity names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.




Process
1.	Loads the reshape2 library as its need to use the methods melt and  dcast and hence need to make sure we have reshape2
2.	Sets the file name 
3.	Downloads the file 
4.	Unzips the file
5.	Now READ all the files as data frames
6.	Merges the training and the test sets for the X to create one data set.
7.	Skips the first column in the Features and just get the indices of the rows in the 2nd column that contains the mean or standard deviation and stores then as list
8.	Gets all the activities by doing a row bind
9.	Creates feature names list by removing "()" apply to the measurements to rename labels.gsub does a global substitute
10.	Combine test and train of subject data 
11.	Combines the  subject, activity, and mean and std only data set to create ready go measurements 
12.	Creates a molten data frame and then get the mean of the measurements using dcast and finally write a tidy data file
