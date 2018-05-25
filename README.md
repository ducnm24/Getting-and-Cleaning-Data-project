# Getting-and-Cleaning-Data-project
course project
1.  First, loading the "dplyr" and "tibble" packages, then set the working directory

2.  Reading in and appropriately labeling(using "col.names" parameter) the data from the Samsungdata set "UCI HAR Dataset"

    a. features: containing 561 signals/features as well as corresponding ids(1-561)

    b. activity_labels: containing 6 activities as well as corresponding ids(1-6)

    c. X_test/X_train: recored observations from participants

    d. Y_test/Y_train: activity's ids corresponding to above recored observations

    e. subject_test/subject_train: participant identifier corresponding to above recored observations

3.  Merging data

    a. variables are participant, activity and 561 signals

    b. corresponding observations from both test and train dataset

4.  Extracting

    a. finding all the columns whose name contains either "mean" or "std" but not "meanFreq"(meanFreq is described "Weighted average of          the frequency components" so I wouldnot include in)

    b. extracting them as well as subject and activity ids out from the merged dataset and storing in "extract"

5.  Assigning activity names

    a. using activity_labels.txt file to assign activity's id with its corresponding name

6. Labelling dataset 

7.  Averaging out

    a. grouping the data set by subject/participant's id and activity, summrising and applying mean funtion 

8.  Writing
