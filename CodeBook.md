
#Human Activity Recognition Using Smartphones Data Set Cleanup Project
## Overview
This code book describes the input dataset, the requirements and transformation work performed to clean up the input dataset, variables and the data. This work was done as a partial fulfilment of the requirements for the Getting and Cleaning Data Course project.
In this project, a raw data set on human activity recognition was provided as the input. The raw was not very well organized and not descriptive enough to be used in any analysis as is. So, the goal was to clean that data set up to be used for further analysis.

As it described in the University of California Irvine's Human Activity Recognition web site, 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set Information:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

The raw dataset was downloaded from the above URL and further processing is done through several steps to come up with a tidy dataset that is more descriptive and usable for further analysis.  The cleanup process and the resulting data set is described in details in the following sections.

##The data cleanup process

The description of the data cleanup process carried out in this project is broken down into the following sub-sections. 

###The raw data

The raw data was available from the URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

*	/test - This folder has the files for the measurements and corresponding subject and activity data for the test data set
	* subject_test.txt - The subjects for the test observations
	* X_test.txt - The measurements for the test observations
	* Y_test.txt - The activities for the test observations
*	/train
	* subject_train.txt - The subjects for the test observations
	* X_train.txt - The measurements for the test observations
	* Y_train.txt - The activities for the test observations
*	features.txt - The full list of measurements variables captured in each observation
*	feature_info.txt - A file that describes the feature vectors used in the HAR study
*	activity_labels.txt -  The unique list of human activities observed as part of this study.
*	README.txt - The README file describing the dataset
The above zip file contained a root folder UCI HAR Dataset. This root folder had two subfolders and 4 files. They are:


### The problem

The given raw input dataset had all the required data but scattered around in multiple different files. The test and train observations are separate and the associated activity and subject data are in different files.  In addition to this, the activities and the measured variables logged for each observation are not very well described. 

###The solution

Take the R approach to consolidate data from various files, subset the required variables and provide more descriptive headers so that it will be easier for further analysis

### The process

*	At first, the zip file downloaded and extracted to a local folder.
*	The individual files are then visually reviewed for content.
*	Next, the features.txt file is loaded as a data table named column names into R. From this data table, the features names vector named columnNames is created . Two more values named Subject and Activity are added to the resulting vector. 
*	Next, the subject, activity and measurements files for the test dataset are loaded as data tables into R.
*	The data tables for test subject, activity and the measurements are then merged using the cbind function. The resulting combined data table had 2947 rows and 563 columns (561 measurements and 2 columns for subject and activity)
*	Next, the subject, activity and measurements files for the train dataset are loaded as data tables into R.
*	The data tables for train subject, activity and the measurements are then merged using the cbind function. The resulting combined data table had 7352 rows and 563 columns (561 measurements and 2 columns one each for subject and activity)
*	The test and train data table are merged to get a full data table with 10299 rows and 563 columns.
*	The full table is next subset to create a smaller table that contained only the Subject, Activity and measurements that are only "mean" and "std".
*	The column headers are then modified using the grepl with regex commands to have more descriptive texts in them.
*	As a final step, the subset data is next aggregated by activity and subject columns to calculate the mean on all the selected measurements.
*	The resulting data set is saved into a HAR_Tidy_Data.csv files using the comma as the separator.

### The R code

The source code in R language for the above cleanup process is placed in the [run_analysis.R] (https://github.com/ckuloor/datacleanupproject/blob/master/run_analysis.R). To exeucte this script, simply run the following in R:

source("run_analysis.R")

## Description of the result data 

### The subjects
The subjects/participants were given as integers ranging from 1 to 30 in the original data set. There were no other descriptions available about the subjects. Hence the result is also using those number for subjects.

### The activities
There are 6 unique activities.  They were given as numbers ranging from 1 to 6 in the original data set. However, there was an additional file available that had the labels for each activity. Hence the tied up is using the descriptive labels in the file instead of the original numbers.
* 1 - WALKING
* 2 - WALKING_UPSTAIRS
* 3 - WALKING_DOWNSTAIRS
* 4 - SITTING
* 5 - STANDING
* 6 - LAYING

### The measurement variables 

The variables in the final tidy data set are the average of the select mean and standard deviations measurements from the original data set grouped by the activities and subjects. For a detailed description of each of the measurements, please refer to the original data description provided along with the raw data .

* Time_Body_Acceleration_Mean-X
* Time_Body_Acceleration_Mean-Y
* Time_Body_Acceleration_Mean-Z
* Time_Body_Acceleration_SD-X
* Time_Body_Acceleration_SD-Y
* Time_Body_Acceleration_SD-Z
* Time_Gravity_Acceleration_Mean-X
* Time_Gravity_Acceleration_Mean-Y
* Time_Gravity_Acceleration_Mean-Z
* Time_Gravity_Acceleration_SD-X
* Time_Gravity_Acceleration_SD-Y
* Time_Gravity_Acceleration_SD-Z
* Time_Body_Acceleration_Jerk_Mean-X
* Time_Body_Acceleration_Jerk_Mean-Y
* Time_Body_Acceleration_Jerk_Mean-Z
* Time_Body_Acceleration_Jerk_SD-X
* Time_Body_Acceleration_Jerk_SD-Y
* Time_Body_Acceleration_Jerk_SD-Z
* Time_Body_Gyro_Mean-X
* Time_Body_Gyro_Mean-Y
* Time_Body_Gyro_Mean-Z
* Time_Body_Gyro_SD-X
* Time_Body_Gyro_SD-Y
* Time_Body_Gyro_SD-Z
* Time_Body_Gyro_Jerk_Mean-X
* Time_Body_Gyro_Jerk_Mean-Y
* Time_Body_Gyro_Jerk_Mean-Z
* Time_Body_Gyro_Jerk_SD-X
* Time_Body_Gyro_Jerk_SD-Y
* Time_Body_Gyro_Jerk_SD-Z
* Time_Body_Acceleration_Magnitude_Mean
* Time_Body_Acceleration_Magnitude_SD
* Time_Gravity_Acceleration_Magnitude_Mean
* Time_Gravity_Acceleration_Magnitude_SD
* Time_Body_Acceleration_Jerk_Magnitude_Mean
* Time_Body_Acceleration_Jerk_Magnitude_SD
* Time_Body_Gyro_Magnitude_Mean
* Time_Body_Gyro_Magnitude_SD
* Time_Body_Gyro_Jerk_Magnitude_Mean
* Time_Body_Gyro_Jerk_Magnitude_SD
* Frequency_Body_Acceleration_Mean-X
* Frequency_Body_Acceleration_Mean-Y
* Frequency_Body_Acceleration_Mean-Z
* Frequency_Body_Acceleration_SD-X
* Frequency_Body_Acceleration_SD-Y
* Frequency_Body_Acceleration_SD-Z
* Frequency_Body_Acceleration_Jerk_Mean-X
* Frequency_Body_Acceleration_Jerk_Mean-Y
* Frequency_Body_Acceleration_Jerk_Mean-Z
* Frequency_Body_Acceleration_Jerk_SD-X
* Frequency_Body_Acceleration_Jerk_SD-Y
* Frequency_Body_Acceleration_Jerk_SD-Z
* Frequency_Body_Gyro_Mean-X
* Frequency_Body_Gyro_Mean-Y
* Frequency_Body_Gyro_Mean-Z
* Frequency_Body_Gyro_SD-X
* Frequency_Body_Gyro_SD-Y
* Frequency_Body_Gyro_SD-Z
* Frequency_Body_Acceleration_Magnitude_Mean
* Frequency_Body_Acceleration_Magnitude_SD
* Frequency_Body_Acceleration_Jerk_Magnitude_Mean
* Frequency_Body_Acceleration_Jerk_Magnitude_SD
* Frequency_Body_Gyro_Magnitude_Mean
* Frequency_Body_Gyro_Magnitude_SD
* Frequency_Body_Gyro_Jerk_Magnitude_Mean
* Frequency_Body_Gyro_Jerk_Magnitude_SD
