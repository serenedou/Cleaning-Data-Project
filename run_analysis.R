##1 merge all data into one data set
###feature data
xtrain<-read.table("x_train.txt")#read data
head(xtrain)

dim(xtrain)
xtest<-read.table("x_test.txt")#read data
head(xtest)

totalfeature<-rbind(xtrain,xtest)#combine the feature data from test and train: 10299 rows and 561 columns.
head(totalfeature)
dim(totalfeature)

### subject data
subjecttrain<-read.table("subject_train.txt")
head(subjecttrain)
names(subjecttrain)[1]<-"subjectnumber"
subjecttest<-read.table("subject_test.txt")
names(subjecttest)[1]<-"subjectnumber"
head(subjecttest)
totalsubject<-rbind(subjecttrain,subjecttest)#it works: combined subject data train and test
#the total subject is a marker for the 30 subjects
dim(totalsubject)
head(totalsubject)

#add subject data to feature data
totalfeatureSubject<-cbind(totalsubject,totalfeature)
dim(totalfeatureSubject)
totalfeatureSubject[1:4,560:562]#just for test of data correctness

###activity data: merge all the training and test data.
ytrain<-read.table("y_train.txt")
names(ytrain)[1]<-"activitytype"
head(ytrain)
dim(ytrain)
ytest<-read.table("y_test.txt")
names(ytest)[1]<-"activitytype"
head(ytest)
dim(ytest)
totalactivity<-rbind(ytrain,ytest)#combine activity data training and test.
head(totalactivity)
dim(totalactivity)

##add labels to activity data
activity<-read.table("activity_labels.txt")
names(activity)[1]<-"activitytype"
names(activity)[2]<-"activityname"
head(activity)
dim(activity)

totalactivity$activitytype<-factor(totalactivity$activitytype,
                                   levels=c(1,2,3,4,5,6),
                                   labels=c(" WALKING"," WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING",
                                            " STANDING","LAYING"))

##add activity type to totalfeatureSubject dataset to get the final clean data set
totalfeatureSubjectType<-cbind(totalfeatureSubject,totalactivity)
dim(totalfeatureSubjectType)
totalfeatureSubjectType[1:4,560:563]#test whether all data are included

#2.extract dataset with only SD and mean
######feature name data
featurename<-read.table("features.txt")# I have no better way to subset with discrete rows...

x1<-featurename[1:6,]
x2<-featurename[41:46,]
x3<-featurename[81:86,]
x4<-featurename[121:126,]
x5<-featurename[161:166,]
x6<-featurename[201:202,]
x7<-featurename[227:228,]
x8<-featurename[253:254,]
x9<-featurename[266:271,]
x10<-featurename[294:296,]
x11<-featurename[345:350,]
x12<-featurename[373:375,]

x13<-featurename[424:429,]
x14<-featurename[503:504,]
x15<-featurename[516:517,]
x16<-featurename[542:543,]
x17<-featurename[556:561,]

meanSD<-rbind(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17)
dim(meanSD)
####With the row number of the mean and SD data for measurement, we can use similar way to get the subset of the 563 total data set
y1<-totalfeatureSubjectType[,1:6]
y2<-totalfeatureSubjectType[,41:46]
y3<-totalfeatureSubjectType[,81:86]
y4<-totalfeatureSubjectType[,121:126]
y5<-totalfeatureSubjectType[,161:166]
y6<-totalfeatureSubjectType[,201:202]
y7<-totalfeatureSubjectType[,227:228]
y8<-totalfeatureSubjectType[,253:254]
y9<-totalfeatureSubjectType[,266:271]
y10<-totalfeatureSubjectType[,294:296]
y11<-totalfeatureSubjectType[,345:350]
y12<-totalfeatureSubjectType[,373:375]
y13<-totalfeatureSubjectType[,424:429]
y14<-totalfeatureSubjectType[,503:504]
y15<-totalfeatureSubjectType[,516:517]
y16<-totalfeatureSubjectType[,542:543]
y17<-totalfeatureSubjectType[,556:561]

meanSDCleanData<-cbind(y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17)
meanSDCleanData[10298:10299,]#test dataset
dim(meanSDCleanData)
dim(totalfeatureSubjectType)

#3 name activity names to name the activity in the dataset
###this part has been down in the 1. I have merge the activity level to the whole dataset
WithActivityName<-totalfeatureSubjectType
WithActivityName[1:2,560:563]

#4label variables with names: I give up rename the V1-V561 variables as I could not think of a better way than just name each of them manually, which is unwise to do.


#5create a data set with avgs of each variable for each activity and subject
z1<-totalfeatureSubjectType[,1:3]
z2<-totalfeatureSubjectType[,41:43]
z3<-totalfeatureSubjectType[,81:83]
z4<-totalfeatureSubjectType[,121:123]
z5<-totalfeatureSubjectType[,161:163]
z6<-totalfeatureSubjectType[,201]
z7<-totalfeatureSubjectType[,227]
z8<-totalfeatureSubjectType[,253]
z9<-totalfeatureSubjectType[,266:268]
z10<-totalfeatureSubjectType[,294:296]
z11<-totalfeatureSubjectType[,345:347]
z12<-totalfeatureSubjectType[,373:375]
z13<-totalfeatureSubjectType[,424:426]
z14<-totalfeatureSubjectType[,503]
z15<-totalfeatureSubjectType[,516]
z16<-totalfeatureSubjectType[,542]
z17<-totalfeatureSubjectType[,556:563]

meanCleanData<-cbind(z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16,z17)
dim(meanCleanData)
meanCleanData[1:3,40:44]#test subject number and activitytype added
library(plyr)
install.packages("reshape2")
library(reshape)
melted<-melt(meanCleanData,id.vars=c("subjectnumber","activitytype"))
meanActivitySubject<-ddply(melted,c("subjectnumber", "activitytype"),summarise,mean=mean(value))
dim(meanActivitySubject)
#output as text file
write.table(meanActivitySubject, file="tidydata2.txt")
read.table("tidydata2.txt")
