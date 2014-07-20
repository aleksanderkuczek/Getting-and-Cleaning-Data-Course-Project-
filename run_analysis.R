run_analysis <- function () {
    
    ## Code styling in accordance with Google's R Style Guide
    ## https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
    
    library("plyr")
    
    # Preparing to read data from files
    # Defining folder and file names
    foldersToReadFrom <- c("test","train")
    filesPrefixToReadFrom <- c("y_", "subject_", "X_")
    path <- "UCI HAR Dataset/"
    
    # Reading data form main folder.
    # Will be used later as column names and levels in factors.
    pathToFeaturs <- paste(path, "features.txt", sep = "")
    features <- read.table (pathToFeaturs, row.names = 1, 
                            stringsAsFactors=FALSE)
    pathToActivityLabels <- paste(path, "activity_labels.txt", sep = "")
    activityLabels <- read.table(pathToActivityLabels, row.names=1)
    
    #An outer for loop to read data form subfolders
    for (n in 1:length(foldersToReadFrom)) {
        # Creating a path to read from
        pathToSubfolder <- paste(path, foldersToReadFrom[n], "/", sep = "")
        # An inner for loop to read files in each folder
        for (m in 1:length(filesPrefixToReadFrom)) {
            fileName <- paste (filesPrefixToReadFrom[m], foldersToReadFrom[n], 
                                  sep = "")
            pathToFile <- paste(pathToSubfolder, fileName, ".txt", sep = "")
            
            # Reading TXT file and assigning it to varible
            rawData <- read.table(pathToFile)
            
            # Binding columns from different files together
            if (m == 1) {
                cBindedRawData <- rawData
            } else {
                cBindedRawData <- cbind(cBindedRawData, rawData)   
            }

        # End of inner loop
        }
        
        # Binding rows form different folders together
        if (n == 1)
        {
            rBindedRawData <- cBindedRawData
            remove(cBindedRawData)
        } else {
            rBindedRawData <- rbind(rBindedRawData, cBindedRawData)            
        }

    # End of outer loop
    }
    
    # Setting column names
    features <- read.table (
        paste(path, "features.txt", sep=""),
        row.names = 1, 
        stringsAsFactors=FALSE)
    ColNames <- c("activity", "subject", features[, 1])
    colnames(rBindedRawData)<- ColNames
    
    # Creating factor for activities
    activityLabels <- read.table(
        paste(path, "activity_labels.txt", sep=""), 
        row.names=1,
        stringsAsFactors=FALSE)
    rBindedRawData[, 1] <- as.factor(rBindedRawData[, 1])
    levels(rBindedRawData[, 1]) = activityLabels[, 1]
    
    # Subseting. Leaving only columns that contain "std()" or "mean()" in name
    # together with subject and activity column
    subsettedRawData <- subset(rBindedRawData, select = c(
        1,
        2,
        grep("std()", colnames(rBindedRawData)),
        grep("mean()", colnames(rBindedRawData))
        ))
    
    # First data set ready. Now creating the second data set cosisiting only
    # of means of each varible for every activity/subject combination.
    meanData <- ddply(subsettedRawData, .(activity, subject), numcolwise(mean))

    
    # Returing the two required data set
    list(meanData, subsettedRawData)
    
}
