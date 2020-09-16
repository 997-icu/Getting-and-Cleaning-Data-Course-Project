
#working directory
setwd("D:/Coursera/Specialization/Data Science Specialization/Getting and Cleaning Data/week4")

#download the zip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_prjeoctfiles_UCI HAR Dataset.zip")

#unzip the file
unzip("getdata_prjeoctfiles_UCI HAR Dataset.zip")



library(tidyverse) #including dplyr

#set working directory again
setwd("D:/Coursera/Specialization/Data Science Specialization/Getting and Cleaning Data/week4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")


# Load activity labels + features
activity_labels <- read.table("activity_labels.txt")

#change factor to character
class(activity_labels[,2])
activity_labels[,2] <- as.character(activity_labels[,2])

#change factor to character
features <- read.table("features.txt")
features[,2] <- as.character(features[,2])






################2. Extracts only the measurements on the mean and standard deviation for each measurement.

#We should extract the features we want first ,or the merged data will be very messy

# .* means any character shows up any time
mean_and_std <- grep(".*mean.*|.*std.*", features[,2])

#add names
mean_and_std.names <- features[mean_and_std,2]

#replace the character
mean_and_std.names = gsub('-mean', 'Mean', mean_and_std.names)
mean_and_std.names = gsub('-std', 'Std', mean_and_std.names)
mean_and_std.names <- gsub('[-()]', '', mean_and_std.names)

mean_and_std.names





###########################1. Merges the training and the test sets to create one data set.

# Load the datasets of train and test
X_train <- read.table("./train/X_train.txt")[mean_and_std]
Y_train <- read.table("./train/Y_train.txt")
subject_train <- read.table("./train/subject_train.txt")


X_test <- read.table("./test/X_test.txt")[mean_and_std]
Y_test <- read.table("./test/Y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

#merge the train and test sets
train_dataset <- cbind(subject_train,Y_train , X_train)
test_dataset <- cbind(subject_test, Y_test, X_test)

# merge final datasets 
final_Data <- rbind(train_dataset, test_dataset)





#############################4. Appropriately labels the data set with descriptive variable names.
colnames(final_Data) <- c("subject", "activity", mean_and_std.names)
final_Data





############################  3.Uses descriptive activity names to name the activities in the data set

#use the activity name for the number
final_Data$activity
activity_labels$V1
activity_labels$V2

#integer
class(activity_labels$V1)  
class(final_Data$activity)


#name the activity using lapply function
final_Data$activity <- lapply(final_Data$activity,function(x) {activity_labels$V2[which(activity_labels$V1 == x)]  })
final_Data$activity

class(final_Data$activity)
class(final_Data$subject)

final_Data$subject <- as.factor(final_Data$subject)


#should be changed to factor or we can't using group_by
final_Data$activity <- factor(final_Data$activity,levels = activity_labels$V2)
    
str(final_Data$activity)
str(final_Data$subject)




#####################5.From the data set in step 4, 
####################creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

final_tidy_data <- final_Data %>% group_by(activity,subject) %>% summarise_all(mean)

final_tidy_data
# write the  tidy data into a csv file
write_csv(final_tidy_data,"final_tidy_data.csv")
