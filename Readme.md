## Cleaning and summarising Human Activity Recognition Using Smartphones Dataset

# Overview 
A data set from experiments with volunteers subdivided into test and training sets, who undertook various activities, was cleaned and summarised. The variables included identifiers for subject, activity, and subset as well as measures derived from an accelerometer and gyrometer. See details of data set below *

# Method

* The UCI_HAR_dataset provided was downloaded and unzipped
* The readme.txt file provided was read. The 7 files listed below** were read into r.
* The dplyr rename function was used to rename the variables in the ytest and ytrain data subsets to activity and subjecttest to subject
* ytest and xtest were combined using cbind to produce test
* test was combined with subjecttest to produce testall
* the variable set was added and allocated the test value
* the same process was followed with the train data sets to produce trainall
* testall and trainall were combined using rbind to produce testtrain
* testtrain was reordered so that the set variable was first
* The features names were cleaned by deleting commas, hyphens etc. using gsub
* measurement testtrain columns were renamed to the cleaned feature names using rename
* the mean and standard deviation variables were extracted with the identifier variables into testtrainMeanStd
* activity code values were recoded to activity names
* the variable names were replaced with descriptive names 15 aggregate was used to calculate the average of each measurement variable grouped by activity and subject into a new data set called aggtesttrain
* the group variables were renamed to activity and subject
* The final data set was written to a text file and uploaded

# Original Data Set
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

Each record included:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.

** The dataset includes the following files:
'README.txt'

'features_info.txt': Shows information about the variables used on the feature vector.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

# Notes:
Features are normalized and bounded within [-1,1].
Each feature vector is a row on the text file.
For more information about this dataset contact: activityrecognition@smartlab.ws

# License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.