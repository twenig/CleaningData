run_analysis <- function(){
        
        library(plyr)
        library(reshape2)
        
        current_wd <- getwd()
        
        #Download the zip file containing data to the working directory and unzip the files
        if (!file.exists("data")){
                dir.create(file.path(getwd(), "data"))
                setwd(file.path(current_wd, "data"))
                download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip")
                unzip("dataset.zip")
                setwd(current_wd)
        }
        
        #Read activty labels from activity_label.txt file which have desctiptions of activities
        activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")
        colnames(activity_labels) <- c("activity_id","activity_name")
        
        #Read in features from feature.txt file which describe each column in the training and test set files, rename columns
        features <- read.table("data/UCI HAR Dataset/features.txt")
        colnames(features) <- c("id","feature_label")
        
        #Read in training and test sets with data for features labeled in the features file
        train_set <- read.table("data/UCI HAR Dataset/train/X_train.txt")
        test_set <- read.table("data/UCI HAR Dataset/test/X_test.txt")
        
        #Read in training and test lables which identify the action taken for each row in the training and test set files, rename columns
        train_labels <- read.table("data/UCI HAR Dataset/train/y_train.txt")
        test_labels <- read.table("data/UCI HAR Dataset/test/y_test.txt")
        colnames(train_labels) <- "activity_id"
        colnames(test_labels) <- "activity_id"
        
        #Read in test and training subject files that identify which subject performed the action, rename columns
        train_subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
        test_subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
        colnames(train_subject) <- "subject"
        colnames(test_subject) <- "subject"
        
        #Merge the training and the test sets into one data set called combined_set
        combined_set <- rbind(train_set, test_set)
        
        #Extract only the measurements on the mean and standard deviation for each measurement
        #Find columns with features with "mean" or "std" in the label
        mean_std_features <- grep("mean\\(\\)|std\\(\\)",features$feature_label)
        mean_std_feature_labels <- features$feature_label[mean_std_features]
        
        #Create a new data set with only the needed features
        required_set_data <- combined_set[mean_std_features]
        
        #Use descriptive activity names to name the activities in the data set
        #Combine activity labels for training and test sets
        combined_labels <- rbind(train_labels, test_labels)
        combined_labels <- join(combined_labels,activity_labels,'activity_id')
        #Remove the unneeded column from the combined labels table
        combined_labels$activity_id <- NULL
        
        #Approproately label the data set with descriptive variable names form feature file
        colnames(required_set_data) <- features$feature_label[mean_std_features]
        
        #Create one data frame with training and test sets, subject IDs, and activity names
        combined_subject <- rbind(train_subject, test_subject)
        tidy_data <- cbind(required_set_data, combined_labels, combined_subject)
        
        #Create independent data set with avereage of each variable for each activity and each subject
        #Melt and reshape data to get the mean of each variable associated with subject and activity
        tidy_melt <- melt(tidy_data, id=c("activity_name","subject"),measure.vars=mean_std_feature_labels)
        tidy_melt <- dcast(tidy_melt, subject + activity_name ~ variable, mean)
        
        #Clean up Column Names, based on data from features_info.txt
        sub("t","time",names(tidy_melt))
        sub("f","frequency",names(tidy_melt))
        
        current_wd <- getwd()
        if (file.exists("output")){
                setwd(file.path(current_wd, "output"))
        } 
        else {
                dir.create(file.path(getwd(), "output"))
                setwd(file.path(current_wd, "output"))
        }
        
        #Write tidy data to file without row names, comma separated
        write.table(tidy_melt, "tidydata.txt", sep = ",",row.names=FALSE)
        
        #Set working directory back to original
        setwd(current_wd)
}