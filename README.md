Cleaning-Data-Project
=====================
Here are the steps we take to mersure the data sets to help you understand how we approach this merge and clean assignment.

Combine the disparate data sets into one. 1. We combine the x_train.txt with the x_test.txt to come up with a data set that include all the training and test data for the 561 feature variables with 10299 observations and name it "totalfeature". 2. We combine the subject_train.txt with the subject_test.txt to come up with a data set that assigns the 10299 observations (training and test) with 30 subjects, and name it "total subject". 3. We combine "totalfeature"with "totalsubject to come up with a data set that have 561 feature variables plus subject variable of 10299 observations, and name it"totalfeatureSubject". 4. We combine the y_train.txt with y_test.txt to come up with a data set that assigns activity type of 6 to 10299 observations, and name it"totalactivity". 5. We add labels for the 6 activity type to the "totalactivity" and combine this with "totalfeatureSubject" to come up with the final clean data set with 563 variables including 561 feature variables, subject number, and activity type and we have a total of 10299 observations, and name it "totalfeatureSubjectType".

Extrac data with mean and SD for each measurement. The way we approach is intuitive but may not be the most efficient way. We subset those columns with mean and SD and cbind them to come up with the data set with the name of "meanSDCleanData"" with 72 variables and 10299 observations.

Name activity names to name the activity in the dataset. This has been done in combining disparate data sets into one named"totalfeatureSubjectType".

Label variables with names. I failed to name the 561 variables due to a lack of interest to label them one by one, but have named the other two added variable with names of "subjectnumber" and "activitytype".

Create a data set with avgs of each variable for each activity and subject. First we pick up only those variable with mean in it and cbind them into one data set called"meanCleanData" with 44 variables of 10299 observations. We come up with a mean of all the feature measures as "mean" for each subject per activity, and we name it "meanActivitySubject" with three variables (subjectnumber,activitytype and mean) of 180 observations.
