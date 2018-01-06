## Code Book for Getting and Cleaning Data Project

This code book summarises the steps taken and variables used to produce the tidy dataset, `TidyDataSet.txt`.

### Data

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Section 1. Download zip file from site listed above and unzip to folder in working directory
* `filename`: name given to downloaded file
* `UCI HAR Dataset`: name given to folder created with unzipped files 

### Section 2: Reading and cleaning data. 
This section reads in data from the unzipped folders and extracts those variables describing means and standard devations
* `activity_labels`: labels describing the different types of activites performed
* `features`: list of each type of measurement made for each activity
* `positions`: column positions of variables containing means or standard deviations
* `MeanStDev`: names of each feature which describes a mean or standard deviation

### Section 3: Cleaning variable names.  
This section simplifies and clarifies the names of the features listed in `MeanStDev`

### Section 4: Load data and subset for mean and standard devation
* `train`: data for training group
* `trainMSTD`: data subsetted for only varibles describing means and standard deviations
* `train_labels`: labels for activity type
* `subject_train`: identifiers for subjects in the train dataset
* `train2`: adds subject and activity columns to training data
* `test`: data for testing group
* `testMSTD`: data subsetted for only varibles describing means and standard deviations
* `test_labels`: labels for activity type
* `subject_test`: identifiers for subjects in the test dataset
* `test2`: adds subject and activity columns to testing data

### Section 5: Merge training and testing data sets 
* `MergeTT`: merged data set, column names are subsequently clarified 

### Section 6: Create factors, melt, and recast data 
In the first part of this section, both activity and subject IDs are turned into factors
* `MergeTTm`: this variable contianed melted data with subject and activity IDs and the rest as variables 
* `MergeTTmean`: this variable takes the passed melted data in the line before and applies means to both subject and activity IDs

### Section 7: Write table with tidy data
This section write a file called `TidyDataSet.txt` which outputs the recasted data with means for each variable

## Activity Labels found in `TidyDataset.txt`

* `WALKING` (value `1`): subject was walking
* `WALKING_UPSTAIRS` (value `2`): subject was walking up a staircase
* `WALKING_DOWNSTAIRS` (value `3`): subject was walking down a staircase
* `SITTING` (value `4`): subject was sitting
* `STANDING` (value `5`): subject was standing
* `LAYING` (value `6`): subject was laying down
