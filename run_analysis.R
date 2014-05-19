run_analysis <- function(){

     require("data.table") ## This function requires the use of the .SD functionality withing the data.table package
     
     ## Load information that is common to both the test and training sets
     activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
     colnames(activity) <- c("activityId", "activityName")
     
     features <- read.table("./data/UCI HAR Dataset/features.txt")
     colnames(features) <- c("featureId", "featureName")
     
     ## Load and tidy the TEST dataset 
          testSet <- as.data.frame(read.table("./data/UCI HAR Dataset/test/X_test.txt"))
          colnames(testSet) <- features$featureName ## label each column with the descriptive feature name from the features.txt file
     
          testActLab <- as.data.frame(read.table("./data/UCI HAR Dataset/test/y_test.txt"))
          colnames(testActLab) <- "activityId" ## label the column as an activity code
     
          testSub <- as.data.frame(read.table("./data/UCI HAR Dataset/test/subject_test.txt"))
          colnames(testSub) <- "subjectId" ## label the column as a subject ID
     
          ## Column bind the activity and subject labels to the test data set to create one combined data frame for the test category
          testDF <- cbind(testSub, testActLab, testSet)
     
          ## Release memory used by test.set, test.act.label, and test.sub
          rm(testSet)
          rm(testActLab)
          rm(testSub)
     
     ## Load and tidy the TRAIN dataset
          trainSet <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
          colnames(trainSet) <- features$featureName
     
          trainActLab <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
          colnames(trainActLab) <- "activityId"
     
          trainSub <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
          colnames(trainSub) <- "subjectId"
     
          trainDF <- cbind(trainSub, trainActLab, trainSet)
          
          ## Release memory used by train.set, train.act.label, and train.sub
          rm(trainSet)
          rm(trainActLab)
          rm(trainSub)
     
     ## consolidate the TRAIN and TEST data frames into one data frame that contains both by using rbind
          allData <- rbind(trainDF, testDF)
     
     ## Release memory used by test.df and train.df data frames. They are no longer needed as they have been merged into the data variable
          rm(testDF)
          rm(trainDF) 
     
     ## Create a data frame (summary.data) that only contains the variables related to the mean or standard deviation of a variable
     summaryData <- allData[ ,grepl("mean", names(allData)) | grepl("std", names(allData))]  ## First, extract all columns that have to do with a variable's mean or standard deviation
     summaryData <- cbind("subjectId" = allData[,1], "activityId" = allData[,2], summaryData) ## Second, column bind the subject id and activity variables to the data frame that has the mean and standard deviation of the data set variables
     summaryData <- merge(activity, summaryData, by.x = "activityId", by.y = "activityId") ## Add activity names to the summary data set using the merge command, merging by id from the activity data frame, and activity in the summary.data data frame
     summaryData[1] <- NULL ## Remove the activity.id column as it is duplicative information because we have the activity.name variable
     
     ## Release memory used by the data,activity, and features variables as they are no longer required
     rm(allData) 
     rm(features)
     rm(activity)
     
     ## Create a tidy data frame with that that averages the observations of each variable (in this case it is already a mean), for each activity and subject
     ## This tidy dataset is created using the .SD function in the data.table package
     summaryData <- data.table(summaryData)
     outputData <- summaryData[, lapply(.SD, mean), by = list(activityName, subjectId), .SDcols = 3:81]
     outputData <- outputData[order(outputData$activityName, outputData$subjectId),]
     
     ## Write outputData to a tab delimited file
     write.table(outputData,file = "tidyData.txt", sep = "\t")
}