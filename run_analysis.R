## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each 
## measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5.From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

library(reshape2)
fileName <- "dataset.zip"

## Create file if not exist!
if(!file.exists(fileName)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, fileName, method = 'curl')
}

if(!file.exists("UCI HAR Dataset")){
        unzip(fileName)
}

##  Read the labels and wanted features
label <- read.table("UCI HAR Dataset/activity_labels.txt")
features.names <- read.table("UCI HAR Dataset/features.txt")
features.nums <- grep("+mean+|+std+", features.names[,2])
featuresMeanStd.names <- features.names[features.nums,]
featuresMeanStd.names <- gsub("*[-()]*", "",featuresMeanStd.names[,2])

## Load the data from train and test
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features.nums]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features.nums]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

## Merge the data and labels
Outputdata <- rbind(train, test)
colnames(Outputdata) <- c("subject", "activity", featuresMeanStd.names)

## Replace activity numbers with readable descriptions
Outputdata$activity <- factor(Outputdata$activity, levels = label[,1], labels = label[,2])

Outputdata.melted <- melt(Outputdata, id = c("subject", "activity"))
Outputdata.mean <- dcast(Outputdata.melted, subject + activity ~ variable, mean)

## Output tidy dataset
write.table(Outputdata.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

