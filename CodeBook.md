The data raw data for this project is from the Human Activity
Recognition Using Smartphones Data Set.

The original experiment information is available a the UCI Machine learning repository.

The url is:
https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The url for the actual data is:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The original data is in a .zip file. Once it is unzipped,
the data is in two different directories in three different
files. For each directory of data, the files are combined
into one data frame in R and then the two data frames are
merged. From this set of data the summarized data set with 
only the means of the means and standard deviations of the
original data is collected and exported to a .csv file. 

As there were 30 subject and 6 activities as such there are
only 180 rows of summarized data.  Each row is the mean of
each reading from the provided data.

The names for the columns for the original data were 
retained as they were descriptive and compact.  Two columns
were added to the data, the subject and activity.

The �subject� is the number given to the test subject

The �activity� is the noun name of the activity the subject 
was performing

The Prefix �t� means it is a time domain variable

The Prefix �f� means it is a frequency domain variable

The �Acc� is for acceleration. This is left shortened for clarity;
 the other names, i.e. Gravity, Jerk and Gyro are self-evident.

The X Y and Z suffixes denote the direction of movement 
logged by the sensor.

Below is the list of the variable names.
 
subject
tBodyAcc.mean...Y











tBodyAccJerk.mean...Y

















tBodyAccMag.std..

tGravityAccMag.std..
tBodyAccJerkMag.mean..



tBodyGyroJerkMag.mean..
tBodyGyroJerkMag.std..
fBodyAcc.mean...X
fBodyAcc.mean...Y
fBodyAcc.mean...Z
fBodyAcc.std...X


fBodyAcc.meanFreq...X

fBodyAcc.meanFreq...Z


fBodyAccJerk.mean...Z

fBodyAccJerk.std...Y





fBodyGyro.mean...Y



fBodyGyro.std...Z
fBodyGyro.meanFreq...X
fBodyGyro.meanFreq...Y

fBodyAccMag.mean..






fBodyBodyGyroMag.std..

fBodyBodyGyroJerkMag.mean..

fBodyBodyGyroJerkMag.meanFreq..






