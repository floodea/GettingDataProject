run_analysis<-function(){
  library(reshape2)
  
  #Download the data set and unzip into target folder
  
  if(!file.exists("data")){dir.create("data")}
  fileurl<-("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  download.file(fileurl,destfile="./data/RunData.zip")
  unzip(zipfile="./data/RunData.zip",exdir="./data")
  
  #read the test data as well as the features and the subject numbers
  
  Data<-read.table(file="./data/UCI HAR Dataset/test/X_test.txt", sep="",na.strings="N/A")
  Features<-read.table(file="./data/UCI HAR Dataset/features.txt", sep=" ",na.strings="N/A")
  Y_test<-read.table(file="./data/UCI HAR Dataset/test/Y_test.txt", sep="",na.strings="N/A")
  Subject_test<-read.table(file="./data/UCI HAR Dataset/test/subject_test.txt", sep="",na.strings="N/A")
  
  #repeat the above for the train data.
  
  Data2<-read.table(file="./data/UCI HAR Dataset/train/X_train.txt", sep="",na.strings="N/A")
  Y_train<-read.table(file="./data/UCI HAR Dataset/train/Y_train.txt", sep="",na.strings="N/A")
  Subject_train<-read.table(file="./data/UCI HAR Dataset/train/subject_train.txt", sep="",na.strings="N/A")
  
  #Reading in the activity labels and subsetting the column
  activity<-read.table(file="./data/UCI HAR Dataset/activity_labels.txt", sep="",na.strings="N/A",stringsAsFactors=FALSE)
  activity<-activity[,2]
  
  #naming the subject and activity columns
  colnames(Subject_test)<-"Subject"
  colnames(Y_test)<-"Activity"
  
  #adding activity names to the activity columns for test and train sets
  for (i in 1:6){
  Y_test[Y_test==i,]=activity[i]
  }
  
  colnames(Subject_train)<-"Subject"
  colnames(Y_train)<-"Activity"
  for (i in 1:6){
    Y_train[Y_train==i,]=activity[i]
  }
  
  #adding feature names to the data set, extracting the features containing only mean and std for test and train and subsetting
  #the data sets
  
  colnames(Data)<-Features$V2
  vv<-grep("mean",Features$V2,"ignore.case = T")
  vw<-grep("std",Features$V2,"ignore.case = T")
  means<-Data[,vv]
  Stds<-Data[,vw]
  
  colnames(Data2)<-Features$V2
  vx<-grep("mean",Features$V2,"ignore.case = T")
  vy<-grep("std",Features$V2,"ignore.case = T")
  means2<-Data2[,vx]
  Stds2<-Data2[,vy]
  
  #binding the activities and subjects to the data sets and
  #removing parentheses and dashes from column names.
  
  Test<-cbind(means,Stds,Subject_test,Y_test)
  colnames(Test)<-gsub("()","",colnames(Test),fixed=TRUE)
  colnames(Test)<-gsub("-","",colnames(Test),fixed=TRUE)
  
  Train<-cbind(means2,Stds2,Subject_train,Y_train)
  colnames(Train)<-gsub("()","",colnames(Train),fixed=TRUE)
  colnames(Train)<-gsub("-","",colnames(Train),fixed=TRUE)
  
  #reshaping the data as required by the subject and activity.
  
  DataMelt<-melt(Test,id=c("Subject","Activity"))
  DataFinal<-dcast(DataMelt,Subject+Activity~variable,mean)
  
  DataMelt2<-melt(Train,id=c("Subject","Activity"))
  DataFinal2<-dcast(DataMelt2,Subject+Activity~variable,mean)

  #binding and ordering the two data sets
  Final<-rbind(DataFinal,DataFinal2)
  Final<-Final[order(Final$Subject),]
  
  #creating a new column that incorporates both the subject and
  #the activity, this is named "ActivitySubject" 
  Final$Subject<-paste(Final$Activity,Final$Subject)
  Final$Activity<-NULL
  colnames(Final)[1]<-"ActivitySubject"
  
  #saving the tidy data set as required
  write.table(Final,file="TidyData.txt",row.name=FALSE,sep=" ")
}