# Coursera "Getting and Cleaning Data" Final Project

## Repository Contents
* ReadMe.md - This file, containing a description of the project and script
* CodeBook.md - A description of the resulting tidy data set
* TidyData.R - The script that produces the tidy set of data based on the raw files listed below

## Data Sources
The raw data comes from the 30 subjects performing daily activities with waist-mounted smartphones with inertial sensors. Please see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more inoformation.

## Data Files
Eight of the files from the above source were required for this data analysis:
* activity_labels.txt - Contains the description of the activity ids listed in the 'y' files
* features.txt - Contains descriptions of each column of data in the 'X' files
* X_train.txt - 561 columns of data for measurements for the training subjects
* X_test.txt - 561 columns of data for measurements for the test subjects
* y_train.txt - One column of data that aligns with the 'X' training subject file that identifies the activity for each line
* y_test.txt - One column of data that aligns with the 'X' test subject file that identifies the activity for each line
* subject_train.txt - One column of data that aligns with the 'X' training subject file that identifies the subject for each line
* subject_test.txt - One column of data that aligns with the 'X' test subject file that identifies the subject for each line

The zip file is downloaded by the TidyData.R script and extracted, so the files do not need to be downloaded manually.

## Overview of Script

The TidyData.R script will download the data and extract it to the working directory.  The script then:

* Reads the eight files into data frames for clean up and analysis
  + Changes column names where necessary for future merges
* Merges the test and training data sets into one data frame using rbind() to create a combined data frame
* Because we are only interested in mean and standard deviation measures for the final data:
  + Searches the features data frame for measures containing "mean()" or "std()"
  + Creates a vector of the measure names that will be used
  + Creates a new data set of the measure data that only includes the relevant columns
* Adds the subject and activity name information to the combined dataset of meassures
  + Combines the data from the subject files (subject_test.txt and subject_train.txt) into one data frame
  + Combines the data from the activity id files (y_test.txt and y_train.txt) into one data frame
  + Updates the activity ids to the activity names originally from the activity_labels.txt file
  + Uses cbind() to add the subject ids and activity names to the data frame of measures
* Creates an independent data set with averages for each variable based on activity and subject
  + Uses melt to prepare the data in the subject-activity-measurements format
  + Uses dcast to reformat the data frame with the means of each measure by subject and then activity
* Writes the new, cleaned up data frame to tidydata.txt in the "output" folder under the working directory
