library(dplyr)
library(tibble)

##READING IN DATA & LABELLING NAMES
feature <- as.tbl(read.table("features.txt", col.names = c("id", "signal"), stringsAsFactors = F))
actlabel <- as.tbl(read.table("activity_labels.txt", stringsAsFactors = F))
xtest <- as.tbl(read.table("./test/X_test.txt", col.names = feature$signal))
xtrain <- as.tbl(read.table("./train/X_train.txt", col.names = feature$signal))
ytest <- as.tbl(read.table("./test/Y_test.txt", col.names = "activitylabels"))
ytrain <- as.tbl(read.table("./train/Y_train.txt", col.names = "activitylabels"))
subtest <- as.tbl(read.table("./test/subject_test.txt", col.names = "subject"))
subtrain <- as.tbl(read.table("./train/subject_train.txt", col.names = "subject"))

##MERGING DATA & LABELLING NAMES
xtest <- bind_cols(subtest, ytest, xtest)
xtrain <- bind_cols(subtrain, ytrain, xtrain)
xtest <- add_column(xtest, set = "test", .after = "activitylabels")
xtrain <- add_column(xtrain, set = "train", .after = "activitylabels")
xtest$set <- "test" 
xtrain$set <- "train"
x <- bind_rows(xtest, xtrain)

##EXTRACTING
pattern <- "mean[^Freq]|std"
extractlist <- grep(pattern, colnames(x))
extract <- x %>% select(extractlist)

##ASSSIGNING ACTIVITY NAMES
x$activitylabels <- as.character(x$activitylabels)
for (i in 1:dim(x)[1]){x$activitylabels[i] <- (actlabel[as.numeric(x$activitylabels[i]),2])}

##AVERAGING OUT
by.subject <- x %>% group_by(subject) %>% summarise_at(.vars = 4:dim(x)[2], mean)
by.activity <- x %>% group_by(activity = as.character(activitylabels)) %>% summarise_at(.vars = 4:dim(x)[2], mean)
avg <- bind_rows(by.subject,by.activity)
avg <- avg %>% add_column(activities = avg$activity, .after = "subject") %>% select(-(dim(avg)[2]+1))

##WRITING
write.table(avg, file = "project.txt", row.names = FALSE)
