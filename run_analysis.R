#Load required packages
library(reshape2)
library(dplyr)

#Section 1: Download and unzip data
filename <- "data.zip"
#Download and unzip the dataset
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Section 2: Reading data and extracting variables of interest
#Read in activity labels and features
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
#Determine positions of variables with mean or standard deviation 
positions <- grep(".*mean.*|.*std.*",features$V2)
#Extract variables containing mean and standard deviation
MeanStDev <- filter(features,grepl(".*mean.*|.*std.*",features$V2)==T)
MeanStDev <- MeanStDev$V2

#Section 3: Clean Variable names
MeanStDev <- gsub('[()]','',MeanStDev)
MeanStDev <- gsub('mean','MEAN',MeanStDev)
MeanStDev <- gsub('std','StDEV',MeanStDev)
MeanStDev <- gsub("^(t)","time",MeanStDev)
MeanStDev <- gsub("^(f)","freq",MeanStDev)
MeanStDev <- gsub("([Bb]ody)","Body",MeanStDev)
MeanStDev <- gsub("[Gg]yro","Gyro",MeanStDev)
MeanStDev <- gsub("GyroMag","GyroMagnitude",MeanStDev)
MeanStDev <- gsub("JerkMag","JerkMagnitude",MeanStDev)
MeanStDev <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",MeanStDev)
MeanStDev <- gsub("AccMag","AccMagnitude",MeanStDev)
meanStDev <- gsub("([Gg]ravity)","Gravity",MeanStDev)

#Section 4: Load data and subset for mean and standard deviation 
#Training Data 
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainMSTD <- train[positions]
train_labels <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train2 <- cbind(subject_train, train_labels, trainMSTD)
#Test Data
test <- read.table("UCI HAR Dataset/test/X_test.txt")
testMSTD <- test[positions]
test_labels <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test2 <- cbind(subject_test, test_labels, testMSTD)

#Section 5: Merge training and testing data sets 
MergeTT <- rbind(train2, test2)
#Change column names
colnames(MergeTT) <- c("SubjectID", "ActivityID", MeanStDev)

#Section 6: Create factors, melt, and recast data 
#Turn ActivityID and SubjectID into factors
MergeTT$ActivityID <- factor(MergeTT$ActivityID, levels = activity_labels$V1, labels = activity_labels$V2)
MergeTT$SubjectID <- as.factor(MergeTT$SubjectID)
#Melt merged data
MergeTTm <- melt(MergeTT, id = c("SubjectID", "ActivityID"))
#Recast melted data with means for SubjectID and ActivityID 
MergeTTmean <- dcast(MergeTTm, SubjectID + ActivityID ~ variable, mean)


#Section 7: Write table with tidy data
write.table(MergeTTmean, "TidyDataSet.txt", row.names = FALSE, quote = FALSE)
