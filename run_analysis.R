library(dplyr)

# read train data
X_train <- read.table("~/Week4/DataSet/train/X_train.txt")
Y_train <- read.table("~/Week4/DataSet/train/Y_train.txt")
Sub_train <- read.table("~/Week4/DataSet/train/subject_train.txt")

# read test data
X_test <- read.table("~/Week4/DataSet/test/X_test.txt")
Y_test <- read.table("~/Week4/DataSet/test/Y_test.txt")
Sub_test <- read.table("~/Week4/DataSet/test/subject_test.txt")

# read data description
variable_names <- read.table("~/Week4/DataSet/features.txt")

# read activity labels
activity_labels <- read.table("~/Week4/DataSet/activity_labels.txt")

# Question 1 - Merges the training and the test sets to create one data set.
X_total <- rbind(X_train, X_test)
Y_total <- rbind(Y_train, Y_test)
Sub_total <- rbind(Sub_train, Sub_test)

# Question 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
selected_var <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
X_total <- X_total[,selected_var[,1]]

# Question 3 - Uses descriptive activity names to name the activities in the data set
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_total[,-1]

# Question 4 - Appropriately labels the data set with descriptive variable names.
colnames(X_total) <- variable_names[selected_var[,1],2]

# Question 5 - From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(Sub_total) <- "subject"
total <- cbind(X_total, activitylabel, Sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "~/Week4/DataSet/tidydata.txt", row.names = FALSE, col.names = TRUE)