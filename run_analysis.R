
readline(prompt="This script will create a directory, download the data and parse it/nPress [enter] to continue")



urlfordata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Check for required packages and installs, got from Faridcher on Stackoverflow
InsPack <- function(pack) { if(!pack %in% installed.packages()) {print(paste("installing", pack))
  install.packages(pack)}else print(paste(pack, " already installed")) }

InsPack("downloader")

library(downloader)

InsPack("plyr")

library(plyr)

InsPack("dplyr")

library(dplyr)

InsPack("data.table")

library(data.table)

##Step 1, run the getting data script
##Creates a path to the current directory then adds a new directory

createsPath <- function() {
  
  if(grepl("ExerciseData$",getwd())){## to check if in already in Exercise Directory
    print("Working directory is already ExerciseData")
    return("Working directory is already ExerciseData")
  }
  if(dir.exists("ExerciseData")){## to check if in Directory already and moves to it
    setwd("./ExerciseData")
    print("have set the working directory to ExerciseData")
    return("have set the working directory to ExerciseData")
    
    }
    ##the the current directory is not Exercise Data and it does not exist, this creates it and moves to it.
    currentPath <- path.expand(getwd())
    print(currentPath)
    newDir <- "ExerciseData"
    dataDir <<- file.path(currentPath, newDir)## the <<- makes the variable dataDir available in the global envirment
    dir.create(dataDir)
    setwd(dataDir)
    print(paste("Created and set working directory to ", getwd()))
  }

      

  
  
   makesfilename <- function(urlname){ ##takes the end of the url and makes a file name from it
    filenamealpha <- strsplit(urlname, split = "%")##splits target url on % sign
    filenamebeta <- unlist(filenamealpha)##gets it out of list so the lenth function works
    lastitem <- length(filenamebeta)##gets the length
    filename <- filenamebeta[lastitem]##selects the last item and makes it the file name
  }
  
  
  gettingdata <- function (sourceurl = urlfordata){
    filename <<- makesfilename(sourceurl)
    if(!file.exists(filename)){
    download(sourceurl, destfile = filename, mode = "wb")#uses the download package. I really don't know what the wb is for
    dateDownloaded <<- date()##provides date, I will put this in the Readme file somewhere
    print(paste("Downloaded", filename, 'to', dataDir))} else print(paste(filename, " already in", dataDir))
    }
  
 
  createsPath()
  gettingdata()
  unzip(filename, exdir = dataDir)

  
 
  
  
  ##Step 5 setwd() to "UCI HAR Dataset"
  setwd("UCI HAR Dataset")
  print(getwd())
  print(dir())
  ##Step 6 read the "activity_labels.txt into at a table with read table called activity_labels will uses V2 to change names in the y_test table
  activity_labels <- read.table("activity_labels.txt") ##no need to get fancy just going to look at this
  
  ##Step 7 read the "features.txt into a table with read table to called features will filter this to get the column names needed when downloading the x-test data
  features <- read.table("features.txt")
  
  ##Step 8 setwd working directory to "test"
  setwd("test")
  print(dir())
  
  ##Step 9 read the y_test.txt file using the colnames set to "activity and the classes = character
  ##y_test <- read.table("y_test.txt", col.names = "activity", colClasses = "character")
  y_test <- read.table("y_test.txt", col.names = "activity", colClasses = "character")
  
  ##Step 10  change the y_test activity columns to noun names, I am sure there is a way to do this, I couldn't figure it out.
  ##y_test[[1]] <- revalue(y_test[[1]], c("1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs",
  ##"4" = "sitting", "5" = "standing", "6" = "laying"))##changes the factors, (if you don't set column classes
  ##to character you have to coerce it back to replace it, or at least I did) also failure to use the [[]]will leave you with a vector not a table.
  y_test[[1]] <- revalue(y_test[[1]], c("1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs","4" = "sitting", "5" = "standing", "6" = "laying"))
  
  ##Step 11 read the subject_test.txt in using read.table with the col.names = "subject_test"
  subject_test <- read.table("subject_test.txt", col.names = "subject")
  
  ##Step 12 read the x_test data in using the read.table with the col.names set to features$V2
  ##this reads the entire set in and gives it column headers you can read.
  x_test <- read.table("x_test.txt",col.names = features$V2)
  
  ##Step 13 remove all the unwanted data from the x_test data set by filtering the values in the columns by std and mean
  ##x_test <- x_test[, (names(x_test) %in% grep("*std* | *mean*", names(x_test), value = TRUE))]##using this, anything can
  ##be dropped into the grep statement and a temp variable is not required
  x_test <- x_test[, (names(x_test) %in% grep("*std*| *mean*", names(x_test), value = TRUE))]
  
  ##Step 14 use cbind to bind the the three data tables together
  test_data <- cbind(subject_test, y_test, x_test)
  
  ##Step 15 move  to train directory
  setwd("C:/Users/JS3835/Documents/ExerciseData/UCI HAR Dataset/train")
  print(getwd())
  print(dir())
  ##NOTE: The following steps are identical to 6 through 12, I am just too lazy to build a function to make it
  ##happen all at once.
  
  ##Step 16 read the y_train.txt file using the colnames set to "activity and the classes = character
  ##y_train <- read.table("y_train.txt", col.names = "activity", colClasses = "character")
  y_train <- read.table("y_train.txt", col.names = "activity", colClasses = "character")
  
  ##Step 17  change the y_train activity columns to noun names, I am sure there is a way to do this, I couldn't figure it out.
  ##y_train[[1]] <- revalue(y_train[[1]], c("1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs",
  ##"4" = "sitting", "5" = "standing", "6" = "laying"))##changes the factors, (if you don't set column classes
  ##to character you have to coerce it back to replace it, or at least I did) also failure to use the [[]]will leave you with a vector not a table.
  y_train[[1]] <- revalue(y_train[[1]], c("1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs","4" = "sitting", "5" = "standing", "6" = "laying"))
  
  ##Step 18 read the subject_train.txt in using read.table with the col.names = "subject"
  subject_train <- read.table("subject_train.txt", col.names = "subject")
  
  ##Step 19 read the x_train data in using the read.table with the col.names set to features$V2
  ##this reads the entire set in and gives it column headers you can read.
  x_train <- read.table("x_train.txt",col.names = features$V2)
  
  ##Step 20 remove all the unwanted data from the x_train data set by filtering the values in the columns by std and mean
  x_train <- x_train[, (names(x_train) %in% grep("*std*|*mean*", names(x_train), value = TRUE))]##using this, anything can
  ##be dropped into the grep statement and a temp variable is not required
  
  ##Step 21 use cbind to bind the the three data tables together
  train_data <- cbind(subject_train, y_train, x_train)
  
  
  ##Now with two data sets we are ready to Merge!
  
  ##Step 22 merge the data with the join command
  all_data <- merge(train_data, test_data, all = TRUE)
  readline(prompt="All the data has been merged, the structure of all_data is printed\n the Press [enter] to continue\n")
  
  print(str(all_data))
  readline(prompt="All the data has been merged, the structure of all_data is printed\n the Press [enter] to continue\n")
  
  
  ##Step 23 group by subject and activity and take the mean for each
  means_all_data <- all_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))
  
  
  print(str(means_all_data))
  readline(prompt="All the data has been summarized, the structure of means_all_data is printed\n the Press [enter] to continue\n")
  
  setwd(dataDir)##sets the working directory back to the ExerciseData Directory created earlier
  print(getwd())
  print(dir())
  
  ##Step 24
  ##Creates a csv file from the data so it can be manipulated in any way desired.
  write.csv(file="means_all_data.csv", x = means_all_data, row.names = FALSE)
  write.table(file="means_all_data.txt", x = means_all_data, row.names = FALSE)
  print(getwd())
  print(dir())