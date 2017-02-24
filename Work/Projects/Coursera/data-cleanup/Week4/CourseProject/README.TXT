Getting and Cleaning Data Course Project
=================================================
This repository contains the R script file and the associated CodeBook file prepared for the HAR data cleanup project.

The project requirements:
================================================

Given the raw data set you should create one R script called run_analysis.R that does the following:
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R
==================================================
To run the clean up process, simply place the run_analysis.R file in your working directory and run the following command in R:
 
source("run_analayis.R")
 
Running the script will produce an out file named HAR_Tidy_Data.csv in your working directory.
There are no special libraries required to run this script.