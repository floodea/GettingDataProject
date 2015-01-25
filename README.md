##Getting and Cleaning Data Course Project
------------------------------------------
this includes an r script called run_analysis.R which uses a dataset from the UCI website that contains sensor data from smartphones of 30 individuals engaging in six activities. 
.
###files required by run_analysis

test/X_test.txt: test set
train/X_train.txt:training set
test/Y_test.txt: test labels
train/Y_train.txt: training labels
features.txt: a list of the features
test/subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
activity_labels.txt: Links to the class lables with their activity name.

###run_analysis actions:

- Downloads a dataset from the UCI website which contains sensor data from the smartphones of 30 individuals.
- Unzips the data and loads the above files into R. 
- Names Y_test&Y_train "Activity" and Subject_test&Subject_train  "Subject"
- uses a for loop to Add descriptive names to Y_train and Y_test columns. These are the names of the six activities listed in the activity_labels.txt file
-Adds feature names to the data sets. Extracts the features containing only the mean and standard deviation fromand subsets them.
-Tidies the feature names by removing parentheses and negative signs
-Reshapes the data to create a data set with the average of each variable for each activity and each subject.
-Merges the test and train data sets 
-Orders the merged dataset by subject number
-Combines the Subject and activity features.
-Removes the now-redundant Activity column.
-Renames the new feature "ActivitySubject"
-Saves the tidy data set into the working directory with row.name=false