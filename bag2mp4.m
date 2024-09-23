clc
clear
close all
format compact
%%

experiment_name = "experiment_09202024_1";
test_names = ["cinematic_1", "cinematic_2", "cinematic_3"];

% Define the list of topics you want to extract images from
topicList = ["/stereo/left/image_raw", "/stereo/right/image_raw"];

for a = 1:length(test_names)
    test_name = test_names(a);
    
    video_folder_location = strcat("../rosbags/", experiment_name,"/",test_name,"/", "videos");
    mkdir(video_folder_location)
    
    % Load the bag file
    bag = ros2bagreader(strcat("../rosbags/", experiment_name,"/",test_name,"/",test_name,"_0.db3"));
    
    for t = 1:length(topicList)
        clear selectedMessages msgs
        
        % Select messages from the current topic
        selectedMessages = select(bag, "Topic", topicList{t});
        
        % Read the messages
        msgs = readMessages(selectedMessages);
        length(msgs)
        
        % Create a VideoWriter object
        topicName = strrep(topicList{t}, '/', '_'); % Replace slashes for filename
        video_filename = fullfile(video_folder_location, strcat(topicName, ".avi"));
        writerObj = VideoWriter(video_filename, 'Motion JPEG AVI');
        writerObj.FrameRate = 30; % Set frame rate (adjust as needed)
        open(writerObj);
        
        % Process each message
        for i = 1:length(msgs)
            imgMsg = msgs{i};
            img = rosReadImage(imgMsg);  % Read the image from the message
            
            % Write the image as a frame to the video
            writeVideo(writerObj, img);
        end
        
        % Close the video file
        close(writerObj);
    end
end
