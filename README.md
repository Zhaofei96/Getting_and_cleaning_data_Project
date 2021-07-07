# Getting_and_cleaning_data_Project

This is a course project of Getting and cleaning data(Coursera). 
The data is based from Human Activity Recognition Using Smartphones Dataset(V 1.0)
The students are required to do the following changes:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The R script `run_analysis.R` does the following:
1. Download and unzip the dataset if files don't exist before
2. Load the labels and wanted features(include mean or standard deviation).
3. Load the data of both train and test with wanted features
4. Combine the train and test dataset and rename the colnames
5. Covert activites from num to readable characters
6. Output a dataset called `tidy.txt`