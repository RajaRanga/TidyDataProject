# TidyDataProject
Project for Coursera "Getting and Cleaning Data"
The project features a single R program "run_analysis.R" that processes the UCI Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. The three-axis inertial sensors in a Samsung smartphone were sampled for activities like walking, standing, sitting, etc., this data was further processed to generate a total of 561 different variables for each subject and each activity. More information can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The R program assumes that the .zip file below has been downloaded to the directory in which the R program is present. it also assumes that the files have been unzipped into the directory structure of the zipped file. For example, the path to the X_test.txt file is present in "./UCI HAR Dataset/test".

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R files does the following:
1. Identifies those variables among the 561 different raw and processed variables captured per observation that represent means and standard deviations. These happen to be 81 variables
2. The test and train data sets are then subset to consist of these 81 variables or columns
3. A file of activity values corresponding to each observation is also read in and given the name "activity id"
4. A set of readable labels are added to this activity data as a new column to the data frame as "activity names"
5. The file of subjects is then read. This file gives the subject who corresponds to each observation. Again, this data is given the name "Subject ID."
6. The activity id, activity label and subject Id are then added to the test and train data sets to create a complete data set comprising all information pertaining to each observation.
7. The test and train datasets are then row bound to create one comprehensive dataset called "fin"
8. This "fin" dataset is then "melted" into having one observed value per subject and activity, allowing finally the aggregation of means per subject and activity type.
