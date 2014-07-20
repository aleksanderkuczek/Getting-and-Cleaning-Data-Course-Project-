==================================================================
Getting and Cleaning Data Course Project
CodeBook
==================================================================

The raw data includes as follows:
=========================================
The experiments have been carried out with a group of 30 volunteers within an 
age bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
velocity at a constant rate of 50Hz. The experiments have been video-recorded 
to label the data manually. The obtained dataset has been randomly partitioned 
into two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying 
noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
50% overlap (128 readings/window). The sensor acceleration signal, which has 
gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is 
assumed to have only low frequency components, therefore a filter with 0.3 Hz 
cutoff frequency was used. From each window, a vector of features was obtained 
by calculating variables from the time and frequency domain. See 
'features_info.txt' for more details. 

The way the raw data transformation is performed:
=================================================
Step 1.: Files starting with "y_", "subject_", "X_" are read from folders
"test","train"
Step 2.: Files from each folders are binded together by columns
Step 3.: Data frames from Step 2 are binded together by rows
Step 4.: Names are set for columns. Frist two manually "activity", "subject",
the rest fo the names are imported from features.txt
Step 5.: Factor for activities column is created with proper levels from 
activity_labels.txt
Step 6.: Subseting. Leaving only columns that contain "std()" or "mean()" in 
name together with subject and activity column
Step 7.: Creating additional data frame consisting means of each varible for 
every activity/subject combination.

Varible names:
==============
activity. The name of activity performed
subject. The number of person
The rest of varibles are imported from features.txt and described in raw data.