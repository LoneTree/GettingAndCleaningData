### Attribution  
The code and data in this repository was developed by Brandon Silva and uploaded to github on May 24, 2014. 
email: brandon.j.silva@gmail.com
github: www.github.com/LoneTree
project github repo: www.github.com/LoneTree/GettingAndCleaningData  
files in repo: 
* README.md (this file)
* CodeBook.md - This file describes the variables used in this project, their derivation, and naming convention
* run_analysis.R - source code for the function that produces the output data file "tidyData.txt"
* tidyData.txt - output file for the project. This is a tab delimited file. Description of the data within this file is located in the _Introduction and motivation_ section

### Introduction and motivation  
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. An additional goal is to prepare tidy data that can be used for later analysis. The function that is written should produce a tidy data set as described below.  

### Files used and data structure  
The data are a pre-formed data set obtained from the [University of California - Irvine Machine Learning Repository][UCI link]. The data used in this function are from collected from accelerometers in smartphones, 

Within the zip file downloaded are the following files:
* activity_labels.txt - text file descriptions of the activities monitored for this data set. Activities monitored are:
> * Walking
> * Walking up stairs
> * Walking down stairs
> * Sitting
> * Standing 
> * Laying
* features.txt - list of features used as columns (variables) in this data set. 
* features_info.txt - file that describes the purpose and derivation of many of the variables in the data set
* /test/X_test.txt - the data set of measurements for the test cohort
* /test/y_test.txt - list of the numerical code for each record of measurements
* /test/subject_test.txt - list of subject id codes for each record of measurements
* /train/X_train.txt - the data set of measurements for the test cohort
* /train/y_train.txt - list of the numerical code for each record of measurements
* /train/subject_train.txt - list of subject id codes for each record of measurements

*_Data files for inertial signals were included in the data set but not used in the analysis that this function produces._*

###Assumptions  
The following assumptions have been made about the structure of the original data set and informed the development of this analysis function.  
1. In the original datasets, X represents signal measurements.
2. Y represents the activities that were observed for each measurement.
3. subject_test.txt represents the subject id for each record
4. The order in which the activities and subject ids appear in their files matches the order found in the measurement observations. For example, the first record of measurements found in X text.txt should be matched to the first subject found in subject_text.txt, and the first activity found in the Y file.
5. The order of appearance of variables (e.g. features) in the test and train datasets are the same.
6. Use of inertial signal data is not required.  
7. The result desired by this assignment is essentially an average of averages. 

### Function Logic  
This analysis function follows the high-level process below. The code file contains detailed comments and should be referred to if there are additional questions
1. Require the data.table package from CRAN  
2. Load common data across the train and test data sets (activities, features)  
3. Load the test data set and column bind the subject ids and activities to the test data set to create a consolidated dataset for test  
4. Cleanup and remove temporary data sets  
5. Load the train data set and column bind the subject ids and activities to the train data set to create a consolidated data set for train  
6. Cleanup and remove temporary data sets  
7. Create a data frame (summary.data) that combines the test and train data sets, subsetting to extract columns that only contain the variables related to the mean or standard deviation of a variable  
8. Remove the temporary individual test and train data sets  
9. Create a tidy data frame with that that averages the observations of each variable (in this case each observation is already a mean), for each activity and subject combination. This tidy dataset is aggregates the mean calculation using the .SD function in the data.table package  
10. Cleanup the variable names to ensure variable / column names comply with camel code naming standards and are sufficiently compact AND descriptive.  
11. Write the tidy data frame to a tab delimited text file.  

### Dependencies  
This function requires the data.table package downloadable from the CRAN repository.

[UCI link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
[codebook link] (https://github.com/LoneTree/GettingAndCleaningData/blob/master/CodeBook.md)