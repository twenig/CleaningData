# CodeBook for TidyData.R script (Coursera Getting and Cleaning Data final project)

## Raw Data for Final Tidy Data Set
The raw data comes from 30 subjects performing daily activities with waist-mounted smartphones with inertial sensors. Please see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more information.

## TidyData.txt Final Format
The data in TidyData.txt contains the following:

#### subject
The first column contains the subject ID for the line of data.  This came from two files (subject_train.txt and subject_test) that aligned with the rows of measurement data.

#### activity_name
The second column contains the activity associated with the measures (there will be 6 activities per subject).  This data came from the id in the y_test.txt and y_train.txt files, which were then updated with the actual text activity name from the activity_labels.txt file.

#### measures
Columns 3 through 68 contain the 66 different measures for mean and standard deviation data from the original X_test.txt and X_train.txt files.  The data have been rolled up to an average (mean) for each subject and then activity name, to produce the final TidyData.txt wile with 190 rows (30 subjects with 6 activities each) and 66 columns of measure data.  Column names have been cleaned up to properly display "time" or "frequency", and the unneeded parentheses removed.
