if (!file.exists("HARdata.zip")) {
  datafileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(datafileURL, destfile = "HARdata.zip")
  ## the following will unzip the files to a folder UCI HAR Dataset
  unzip("HARdata.zip")
}

## load the features 
featuresList <- read.table("UCI HAR Dataset/features.txt", col.names = c("id","name"))

## adding two more column names and preparing a full column names vector our data set
columnNames <- c("Subject","Activity", as.vector(featuresList[,"name"]))

## load the test subject, measurements and activity files in order
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testMeasurements <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")

## merge subject, activity data with the test measurements
testDataSet <- cbind(testSubject, testActivity, testMeasurements)

## load the train subject, measurements and activity files in order

trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainMeasurements <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")

## merge subject, activity data with the train measurements
trainDataSet <- cbind(trainSubject, trainActivity, trainMeasurements)

## now merge test and train data set to get the HAR data set
harDataSet <- rbind(testDataSet, trainDataSet)


# Extracts only the measurements on the mean and standard deviation for each measurement.
colNamesFilteredLogical <- grepl("Subject|Activity|\\-mean\\(\\)|\\-std\\(\\)",columnNames)
harMeanAndStds <- harDataSet[,colNamesFilteredLogical]

#Tidy up the features that will be the column names for our data set
columnNamesFiltered <- columnNames[colNamesFilteredLogical]
columnNamesFiltered <- gsub("^t","Time_",columnNamesFiltered)
columnNamesFiltered <- gsub("^f","Frequency_",columnNamesFiltered)
columnNamesFiltered <- gsub("BodyBody","Body",columnNamesFiltered)
columnNamesFiltered <- gsub("Jerk","_Jerk",columnNamesFiltered)
columnNamesFiltered <- gsub("Gyro","_Gyro",columnNamesFiltered)
columnNamesFiltered <- gsub("\\-mean\\(\\)","_Mean",columnNamesFiltered)
columnNamesFiltered <- gsub("\\-std\\(\\)","_SD",columnNamesFiltered)
columnNamesFiltered <- gsub("Mag","_Magnitude",columnNamesFiltered)
columnNamesFiltered <- gsub("Acc","_Acceleration",columnNamesFiltered)

# apply the filtered names to the data set columns
colnames(harMeanAndStds) <- columnNamesFiltered

#read the activity lables and assign them to the activity numbers in the data set
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")# 
harMeanAndStds$Activity <- as.factor(harMeanAndStds$Activity)
levels(harMeanAndStds$Activity) <- as.vector(activityLabels[,2])

# calculate the means for the columns by grouping Activity and Subject
tidyDataSet <- aggregate(. ~ Activity + Subject, data = harMeanAndStds, FUN = mean)

# Save the data into the file
write.table(tidyDataSet, file="HAR_Tidy_Data.csv", sep=',', row.name=FALSE)


