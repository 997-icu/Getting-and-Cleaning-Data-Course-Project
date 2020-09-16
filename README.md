# Getting-and-Cleaning-Data-Course-Project

*The Getting ang Cleaning Data Project.R shows the procedure of my analysis work.(The annotation I wrote in the file is very informative.)
*The CodeBook.md describes the variables of the data.(the procedure that I performed to clean up the data is described in README.md)
*The final_tidy_data.csv shows the final tidy data after cleaning.



# Here is the specific illustration of the procedure:


1. Set the working directory and download the .zip file we need, and unzip the file
2. Read the file activity_labels.txt into R, and change the factor to character
3. Extract only the measurements on the mean and standard deviation for each measurement(I do this before merging the dataset).
4. Merges the training and the test sets to create one data set,using the features above,Y label and subject label.
5. Appropriately labels the data set with descriptive variable names.
6. Uses descriptive activity names to name the activities in the data set
7. creates a second, independent tidy data set with the average of each variable for each activity and each subject. (I do this and create the final tidy data with .csv format.)
