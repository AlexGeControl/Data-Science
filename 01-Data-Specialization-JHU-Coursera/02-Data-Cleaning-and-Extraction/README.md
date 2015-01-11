# Create Tidy Data Set for Human Action Recognition

## Set Up Environment

Set current working direction as the directory containing the script "run_analysis.R"

## Analysis Flow

Please refer to the comments inside the script for detailed description of the analysis flow

Below is the skeleton of the analysis flow:

### Step 1 Create a Merged Data Set with Descriptive Attribute Names

1. Read in "train/X_train.txt", "train/y_train.txt" , "train/subject_train.txt", "test/X_test.txt" , "test/y_test.txt" and "test/subject_test.txt" using 'read.table';

2. Add attribute names for activity ID and subject ID;

### Step 2 Extract Measurements for Mean and Standard Deviation for Each Measurements

1. Use 'grep' with regular expression "mean()|std()" to get attribute indices for the measurements;

2. Then create a sub dataframe using the indices;

### Step 3 Change Numerical Codes for Activities to Descriptive Names

1. Read in the code-name pairs for activities from "activity_labels.txt"

2. Use indexing schemes for R vector to directly convert numerical codes to descriptive names;

### Step 4 Create the New Tidy Data Set

1. First create vectors for activity IDs and subject IDs respectively using 'unique';

2. Extract sub dataframe for each activity and subject using conditional indexing for R dataframe;

3. Calculate mean using 'apply' for each sub dataframe;

4. Insert the generated observation into the target tidy data set;

5. Save the tidy data set as "tidy_data.txt"


