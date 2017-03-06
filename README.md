This script will auto down load the original data and combine it and output 
a .csv file with the data summarized.

WARNING : This is script is not interactive. Once it starts, it will create 
a directory on the host machine, and download a 60 megabyte file and expand 
it into a 350 megabyte set of directories and files. If you are not sure, 
you can step through the script and copy and paste one line at a time, each 
step is clearly noted. 

Once the data is down loaded and read into R, these are the manipulations 
done to the data.

Change the y-test activity columns to noun names.

Remove all the unwanted data from the x-test data set by filtering the values 
in the columns by std and mean.

Bind the subject-test, the y-test and the x-test data frames together.

The same steps are done for the train data.

The data is then merged with merge command

The data is then summarized with the “summarise_all” function

A .csv file is created from the summarized data.


There are some places put into the code that require a "enter"
or "return" input. These are there for timing as some of the 
script over runs other functions and so that the user can read
some of the things printed to the console.
