#
# Contents:
#   Final Project for Getting and Cleaning Data from John Hopkins @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   extract_act_recog_data
# Description:
#   extract Human Activity Recognition Dataset for R
# Notice:
#   make sure that the directory 'UCI HAR Dataset' is in the current working directory
extract_act_recog_data <- function( train_feature_filename = "UCI HAR Dataset/train/X_train.txt" ,
                                    train_label_filename = "UCI HAR Dataset/train/y_train.txt"   ,
                                    train_subject_filename = "UCI HAR Dataset/train/subject_train.txt" ,
                                    test_feature_filename = "UCI HAR Dataset/test/X_test.txt" ,
                                    test_label_filename = "UCI HAR Dataset/test/y_test.txt"   ,
                                    test_subject_filename = "UCI HAR Dataset/test/subject_test.txt"  ) {
  #
  # Step 1 & 4: 
  #   Merges the training and the test sets to create one data set.
  #   Appropriately labels the data set with descriptive variable names.
  # 
  # Training set:
  train_feature_data <- read.table( train_feature_filename , header = FALSE , stringsAsFactors = FALSE )
  train_label_data <- read.table( train_label_filename , header = FALSE , stringsAsFactors = FALSE )
  train_subject_data <- read.table( train_subject_filename , header = FALSE , stringsAsFactors = FALSE )
  train_data <- cbind( train_feature_data , train_label_data , train_subject_data )
  # Test set:
  test_feature_data <- read.table( test_feature_filename , header = FALSE , stringsAsFactors = FALSE )
  test_label_data <- read.table( test_label_filename , header = FALSE , stringsAsFactors = FALSE )
  test_subject_data <- read.table( test_subject_filename , header = FALSE , stringsAsFactors = FALSE )
  test_data <- cbind( test_feature_data , test_label_data , test_subject_data )
  # Merged set:
  data <- rbind( train_data , test_data )
  # Label the data set with descriptive variable names:
  attr_names <- c( extract_feature_names( ) , list( "Activity" , "Subject.ID" ) , recursive = TRUE )
  names( data ) <- attr_names
  
  #
  # Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
  #
  # Indices for means and standard deviations:
  indices <- grep( "mean()|std()" , names( data ) )
  indices <- c( indices , ncol( data ) - 1 , ncol( data ) )
  # Extract sub dataframe:
  data <- data[ , indices ]
  
  #
  # Step 3: Change the values of attr. "Activity" to descriptive names
  #
  activity_names <- extract_activity_names( )
  data$Activity <- activity_names[ data$Activity ]
  
  #
  # Step 5: Creates a new tidy data set with the average of each variable for each activity and each subject
  #
  activities <- unique( data$Activity )
  subjects <- unique( data$Subject.ID )
  tidy_data <- data[ 0 , ]
  num_obs <- 0
  for ( subject in subjects ) {
    for ( activity in activities ) {
      sub_data <- data[ subject == data$Subject.ID & activity == data$Activity , ]
      sub_data_means <- apply( sub_data[ , 1 : ( ncol( sub_data ) - 2 ) ] , 2 , mean )
      num_obs <- num_obs + 1
      tidy_data[ num_obs , 1 : ( ncol( sub_data ) - 2 ) ] <- sub_data_means
      tidy_data[ num_obs , ( ncol( sub_data ) - 1 ) ] <- activity
      tidy_data[ num_obs , ncol( sub_data ) ] <- subject
    }
  }
  # Sort first by Subject.ID then by Activity:
  tidy_data <- tidy_data[ order( tidy_data$Subject.ID , tidy_data$Activity ) , ]
  write.table( tidy_data , "tidy_data.txt" , row.name = FALSE )
  
  return( tidy_data )
}

# Function: 
#   extract_feature_names
# Description:
#   extract feature names from the cookbook
# Notice:
#   make sure that the directory 'UCI HAR Dataset' is in the current working directory
extract_feature_names <- function( feature_labels_filename = "UCI HAR Dataset/features.txt" ) {
  data <- read.table( feature_labels_filename , header = FALSE , stringsAsFactors = FALSE )
  
  return( data[ 2 ] )
}

# Function:
#   extract_activity_names
# Description:
#   extract activities from the cookbook
# Notice:
#   make sure that the directory 'UCI HAR Dataset' is in the current working directory
extract_activity_names <- function( activity_labels_filename = "UCI HAR Dataset/activity_labels.txt" ) {
  data <- read.table( activity_labels_filename , header = FALSE , stringsAsFactors = FALSE )
  
  return( data[[ 2 ]] )
}