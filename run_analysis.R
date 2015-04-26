## Getting and Cleaning Data Course Assignment - 26/04/2015
## 
## run_analysis. R
##
## setup
#setwd("R/proj")
#getwd()
# Find columns in the data set that contain mean and sd values
# This information is contained in UCI HAR Dataset\features.txt
readdir<-"UCI HAR Dataset"
readfile<-"features.txt"
feat<-read.table(paste("./",readdir,"/",readfile,sep=""))
# sqldf library required for the next bit
library(sqldf)
subfeat<-sqldf("select * from feat where V2 LIKE '%mean%' OR V2 LIKE '%std%'")
# subfeat[,1] is a set of column indices to use to subset input data
# Now read in all the training data
readdir<-"UCI HAR Dataset/train"
readfile<-"X_train.txt"
train<-read.table(paste("./",readdir,"/",readfile,sep=""))
# now read y_train, i.e., activity
readdir<-"UCI HAR Dataset/train"
readfile<-"y_train.txt"
ytrain<-read.table(paste("./",readdir,"/",readfile,sep=""))
# now read subject_train, i.e., observed subjects
readdir<-"UCI HAR Dataset/train"
readfile<-"subject_train.txt"
subtrain<-read.table(paste("./",readdir,"/",readfile,sep=""))
# Let us try and replace activity numbers with activity labels

#install.packages("car")
library(car)
ytrain$act<-recode(ytrain$V1,"'1'='Walking';
                   '2'='Walking_Upstairs';
                   '3'='Walking_downstairs';
                   '4'='Sitting';
                   '5'='Standing';
                   '6'='Lying Down' ")
#table(ytrain$act)
colnames(ytrain)<-c("Activity ID", "Activity Name")
colnames(subtrain)<-"subject ID"
subtrain<-cbind(subtrain,ytrain)
# subset train to only means and stds
subset_train<-train[,subfeat[,1]]
# get good names for columns
colnames(subset_train)<-subfeat$V2
# now column bind the subject, activity and this data
subset_train<-cbind(subtrain,subset_train)
##
## Repeat all of the above for the test dataset
##
readdir<-"UCI HAR Dataset/test"
readfile<-"X_test.txt"
test<-read.table(paste("./",readdir,"/",readfile,sep=""))
# now read y_test, i.e., activity
readdir<-"UCI HAR Dataset/test"
readfile<-"y_test.txt"
ytest<-read.table(paste("./",readdir,"/",readfile,sep=""))
# now read subject_train, i.e., observed subjects
readdir<-"UCI HAR Dataset/test"
readfile<-"subject_test.txt"
subtest<-read.table(paste("./",readdir,"/",readfile,sep=""))
# Let us try and replace activity numbers with activity labels

ytest$act<-recode(ytest$V1,"'1'='Walking';
                   '2'='Walking_Upstairs';
                   '3'='Walking_downstairs';
                   '4'='Sitting';
                   '5'='Standing';
                   '6'='Lying Down' ")
colnames(ytest)<-c("Activity ID", "Activity Name")
colnames(subtest)<-"subject ID"
subtest<-cbind(subtest,ytest)
# subset train to only means and stds
subset_test<-test[,subfeat[,1]]
# get good names for columns
colnames(subset_test)<-subfeat$V2
# now column bind the subject, activity and this data
subset_test<-cbind(subtest,subset_test)
##
## Now bind these things together
##
fin<-rbind(subset_train,subset_test)
## Aggregating
#install.packages("reshape")
library(reshape)
finmelt <- melt(fin,id=c("subject ID","Activity ID", "Activity_Name"))
names(finmelt) <- c("Subject","Activity_ID", "Activity Name","Measurement","Value")
finmeans <- aggregate(finmelt$Value,list(finmelt$Subject,
                                               finmelt$Activity_ID,finmelt$Activity_Name,finmelt$Measurement),mean)

