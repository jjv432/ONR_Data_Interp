clc
clear all
close all
format compact
%%
%{
Code to make a rosbag save every frame as a .png.  These pngs will be saved
by timestamp. This is very specific to the relative paths that were used,
but should be easy to adapt to use w/ other directories
jjv20@fsu.edu
%}

%Reference: ChatGPT
% *** For some reason, first three tests have no msgs for right cam

experiment_name = "experiment_09122024_1";

test_names = ["obstacle_test_1", "obstacle_test_2", "obstacle_test_3", "obstacle_test_4"];

% Define the list of topics you want to extract images from
topicList = ["/stereo/left/image_raw", "/stereo/right/image_raw"];


for a = 1:length(test_names)
    test_name = test_names(a);
    
    image_folder_location = strcat("../rosbags/", experiment_name,"/",test_name,"/", "images");
    mkdir(image_folder_location)
    
    % Load the bag file
    bag = ros2bagreader(strcat("../rosbags/", experiment_name,"/",test_name,"/",test_name,"_0.db3"));
    
    % Output folder for saving images
    outputFolder = image_folder_location;

    % Loop through each topic and process the messages
    for t = 1:length(topicList)
        clear selectedMessages msgs

        % Select messages from the current topic
        selectedMessages = select(bag, "Topic", topicList{t});
        
        % Read the messages
        msgs = readMessages(selectedMessages);
        length(msgs)
        
        % Process each message
        for i = 1:length(msgs)
            
            imgMsg = msgs{i};
            img = rosReadImage(imgMsg);  % Read the image from the message
    
            % Create a timestamped filename
            timestamp = imgMsg.header.stamp.sec;
            % Use the topic name to distinguish between left and right images
      
            topicName = strrep(topicList{t}, '/', '_'); % Replace slashes for filename
            filename = sprintf('%s_%.9f.png', topicName, timestamp);
    
            % Create the full file path and save the image
            filepath = fullfile(outputFolder, filename);
            if ~exist(filepath, 'file')
            imwrite(img, filepath);
            end
            
        end
         
        
    end
end