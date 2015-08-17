#use data.table
library(data.table)

# read list of features in data.table to simplify filtering
features <- data.table(read.table("UCI HAR Dataset/features.txt"))
# read list of activities
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("aid", "Activity"))

# add descriptive variable names from features variable while reading data
# merge test and train data into new variables
d_merged <- rbind(read.table("UCI HAR Dataset/test/x_test.txt",col.names = features$V2),
                  read.table("UCI HAR Dataset/train/x_train.txt", col.names = features$V2))
s_merged <- rbind(read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject")),
                  read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject")))
y_merged <- rbind(read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("aid")),
                  read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("aid")))

# choose only mean() and std() columns of d_merged data.frame
filtered_features <- features[V2 %like% "mean" | V2 %like% "std"]
d_merged <- subset(d_merged, select = filtered_features$V1) 

# add subject and activity columns
d_merged <- cbind(s_merged, y_merged, d_merged)

# change activities names and remove link column in big table
d_merged <- merge(d_merged, activities, by.x="aid", by.y="aid")
d_merged <- subset(d_merged,select=-c(aid))

# create second dataset with average values separated for each activity for each subject
# (30*6=180 rows, 79+2=81 (mean+std+subject+activity) cols)
# 1st column is subject, last column is activity

result <- aggregate(d_merged[,2:80], c(d_merged["Subject"], d_merged["Activity"]), 
                    function(x) mean(x,na.rm=T))

# remove everything except result
rm("s_merged")
rm("y_merged")
rm("d_merged")
rm("features")
rm("filtered_features")
rm("activities")

# write the table in csv (so to read it back you can read.csv("output.csv"))
write.table(result, "output.csv", sep=",")