# Overview

The purpose of this repo is to store functions that are used to interpret raw data that was captured with the ONR project.  The following descriptions explain the uses of all of the funcitons and how to use them.

## SwimTestResults.m

This matlab script was used to read all of the rosbags collected off of SELQIE and determine power draw, COT, plots of these two, and total energy.  

When defining the 'names_n_data' array, the first entry in the row is the relative path of the data, second entry is the distance the robot traveled during the trial, and third is the 'apparent' mass of the robot.  There are two options for mass given already, h for 'heavy' (without foam), and l for 'light' (with foam).  These values were experimentally determined.

## bag2mp4.m

This matlab script allows you to take video topics recorded in a ROSBAG and convert them to MP4s.  

You will need to make entries into the 'experiment_name' and 'test_names' arrays.  Experiment_name is the base name of the experiment, and test_names are for each trial.  For example, a trial saved as "FoamExperiment/Trial1" wold have 'FoamExperiment' as the entry for experiment_name, and 'Trial1' as the entry for trial name.  You will also need to change the relative paths in these lines of code: 
` video_folder_location = strcat("../rosbags/", experiment_name,"/",test_name,"/", "videos");`
and
`bag = ros2bagreader(strcat("../rosbags/", experiment_name,"/",test_name,"/",test_name,"_0.db3"));`

Finally, the topicList array will need to be changed based on the name of the topics that you want to convert to MP4.

## bag2png.m

This matlab script has a simliar purpose to bag2mp4.m, but instead of writing the topics to an mp4, it writes to individual images for each frame.

## indexParser.m

This function is used to allow user input on plots.  

This was used to determine the coefficients of friction for the end effector.  By allowing the user to pick when motion started and stopped, calculations could be automated without needing to find a method to determine how much motion was sufficient for the start/end of a trial.

## parseROSBag.m

This function is used to parse diffenet topics from a ROS Bag.

The function has a switch statement for each type of topic name that could be parsed.  In order to parse different topics, change and/or add more cases to the switch.

## tracker2COT.m

This has a similar purpose to SwimTestResults.m.



