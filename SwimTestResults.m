clc
clear
close all
%%
AllCOT(1,:) = ["Experiment Name", "CoT", "average_power", "max_power_peak"];
h = 2.65;
l = .675;
names_n_data = [
    %Sept 9
    % "experiment_09092024_1/jump_test_0_5Hz", 0.225, h; 
    % "experiment_09092024_1/jump_test_0_75Hz", 0.185, h;
    % "experiment_09092024_1/jump_test_1_5Hz", 0.75, h;
    % "experiment_09092024_1/jump_test_1Hz", , h;
    % "experiment_09092024_1/jump_test_2Hz", 4, h;
    % "experiment_09092024_1/jump_test_3Hz", 4, h;

   %Done
    % "experiment_09092024_1/walk_test_0_5Hz", 1.10, h; %all three trials %1
    % "experiment_09092024_1/walk_test_0_75Hz", 0.56, h; %2
    % "experiment_09092024_1/walk_test_1_5Hz", 1.05, h; %3
    % "experiment_09092024_1/walk_test_1_25Hz", 1.001, h; %4
    % "experiment_09092024_1/walk_test_1Hz", 0.96, h; %MISSING DATA on T1 %5

    % "experiment_09092024_2/jump_test_0_5Hz", 7, h;
    % "experiment_09092024_2/jump_test_0_25Hz", .251, h;
    % "experiment_09092024_2/jump_test_0_25Hz_2", 7, h;
    % "experiment_09092024_2/jump_test_0_75Hz", 0.210, h;
    % "experiment_09092024_2/jump_test_0_75Hz_2", 7, h;
    % "experiment_09092024_2/jump_test_1_25Hz", 7, h;
    % "experiment_09092024_2/jump_test_1Hz", 7, h;
    % "experiment_09092024_2/swim_test_1", 7, h;
    % "experiment_09092024_2/swim_test_2", 7, h;
    % "experiment_09092024_2/swim_test_3", 7, h;

    % "experiment_09092024_3/jump_test_0_5Hz", 2, h;
    % "experiment_09092024_3/jump_test_0_25Hz", 2, h;
    % "experiment_09092024_3/jump_test_0_75Hz", 2, h;
    % "experiment_09092024_3/jump_test_1_25Hz", 2, h;
    % "experiment_09092024_3/jump_test_1Hz", 2, h;
    % "experiment_09092024_3/obstacle_test_1", 2, h;
    % "experiment_09092024_3/obstacle_test_2", 2, h;
    % "experiment_09092024_3/obstacle_test_3", 2, h;
    % "experiment_09092024_3/obstacle_test_4", 2, h;
    % "experiment_09092024_3/obstacle_test_5", 2, h;
    % "experiment_09092024_3/swim_test_3_5Hz", 2, h;
    % "experiment_09092024_3/swim_test_4_5Hz", 2, h;
    % "experiment_09092024_3/swim_test_4Hz", 2, h;
    % "experiment_09092024_3/swim_test_5_25Hz", 2, h;
    % "experiment_09092024_3/swim_test_5Hz", 2, h;
    % "experiment_09092024_3/swim_test_drop", 2, h;

    % %Sept 10
    % "experiment_09102024_1/swim_test_2_5Hz", 1, l;
    % "experiment_09102024_1/swim_test_3_5Hz", 1, l;
    % "experiment_09102024_1/swim_test_3_25Hz", 1, l;
    % "experiment_09102024_1/swim_test_3Hz", 1, l;
    % "experiment_09102024_1/swim_test_4_5Hz", 1, l;
    % "experiment_09102024_1/swim_test_4Hz", 1, l;
    
    % %Sept 11 (NF)
    % "experiment_09112024_1/obstacle_test_1", 1, l;
    % "experiment_09112024_1/obstacle_test_2", 1, l;
    % "experiment_09112024_1/obstacle_test_3", 1, l;
    % "experiment_09112024_1/obstacle_test_4", 1, l;
    % "experiment_09112024_1/obstacle_test_5", 1, l;
    % "experiment_09112024_1/obstacle_test_6", 1, l;

    %Sept 12 %Somethings wrong here!!
    % "experiment_09122024_1/obstacle_test_1", 1, l;
    % "experiment_09122024_1/obstacle_test_2", 1, l;
    "experiment_09122024_1/obstacle_test_3", 1, l;

    %Done
    %"experiment_09122024_1/obstacle_test_4", 1, l; %6
    % ^^ Only one of these?? ^^
    % "experiment_09122024_1/walk_test_0_1Hz", .777, l; %7 
    % "experiment_09122024_1/walk_test_0_2Hz", 0.821, l; %8
    % "experiment_09122024_1/walk_test_0_5Hz", 0.707, l; %9
    % "experiment_09122024_1/walk_test_0_25Hz", 0.712, l; %10
    % "experiment_09122024_1/walk_test_0_35Hz", .288, l; %11
    % 


    %Sept 14
    % "experiment_09142024_1/swim_test_finsV1A", 2, h;
    % "experiment_09142024_1/swim_test_finsV1b", 2, h;
    % "experiment_09142024_1/swim_test_finsV1c", 2, h;
    % 
    %Done
    % "experiment_09142024_1/walk_test_1_75Hz", 2, h; % 1
    % "experiment_09142024_1/walk_test_1_75Hz_2", 2, h; % 2
    % "experiment_09142024_1/walk_test_2_5Hz", 2, h; % 3
    % "experiment_09142024_1/walk_test_2Hz", 2, h; % 4
    % "experiment_09142024_1/walk_test_3_5Hz", 2, h; % 5
    % "experiment_09142024_1/walk_test_3Hz", 2, h; % 6
    % "experiment_09142024_1/walk_test_4Hz", 2, h; % 7


];



for a = 1:size(names_n_data, 1)
    clearvars -except names_n_data a AllCOT

% swim_data = parseROSBag("experiment_09092024_1/joystick_test");
swim_data = parseROSBag(names_n_data(a,1));

% Front Left Leg Command vs Estimate

% cmd_time = swim_data.legFL_command.Time;
% est_time = swim_data.legFL_estimate.Time;
% cmd_legZ = swim_data.legFL_command.PosSetpoint(:,3);
% est_legZ = swim_data.legFL_estimate.PosEstimate(:,3);

% figure()
% hold on
% plot(cmd_time, cmd_legZ)
% plot(est_time, est_legZ)
% legend(["cmd", "est"])
% title(names_n_data(a,1))

% Power draw
info0_time = swim_data.odrive0_info.Time;

info0_trial_time = info0_time(end) - info0_time(1);
info0_trial_time = info0_trial_time/3;
info0_current = swim_data.odrive0_info.BusCurrent;
info0_voltage = swim_data.odrive0_info.BusVoltage;
info0_power = info0_current .* info0_voltage;
max_power_peak = max(info0_power);
average_power = rms(info0_power);

%Calculating CoT
%d = 4.5;
d = str2double(names_n_data(a,2));
%m = 2.65;
m = str2double(names_n_data(a,3));
g = 9.81;

fprintf("For experiment: %s\n", names_n_data(a,1));
fprintf(['Calculating with values: \n Distance = %0.1f \n Mass = %0.2f \n ' ...
    'Gravity = %0.2f \n Total Energy = %0.2f \n Trial Time = %0.2f \n'],d,m,g,average_power,info0_trial_time);

info0_total_energy = average_power * info0_trial_time;

CoT = info0_total_energy / (m*g*d);
AllCOT(a+1, :) = [names_n_data(a,1), CoT, average_power, max_power_peak];
fprintf('Average Cost of Transport = %0.2f \n\n',CoT);

figure ()
% subplot(3, 1, 1)
% plot(info0_time-info0_time(1), info0_current)
% subplot(3, 1, 2)
% plot(info0_time, info0_voltage)
% subplot(3, 1, 3)
plot(info0_power)
title(names_n_data(a,1))

end

