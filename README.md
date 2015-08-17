### Summary

I assumed  that data we use is already downloaded.

Clean output is in included txt file "output.txt". To read it you can type read.table("output.txt", sep=",", header=TRUE)

Script logic as follows:
* use data.table
* read list of features in data.table to simplify filtering
* read list of activities
* add descriptive variable names from features variable while reading data
* merge test and train data into 3 variables
* choose only mean and std columns of d_merged data.frame
* add subject and activity columns
* change activities names and remove link column in big table
* create second dataset with average values separated for each activity for each subject
* (30*6=180 rows, 79+2=81 (mean+std+subject+activity) cols)
* remove everything except result
* write the table in txt

Codebook is in file CodeBook.md


