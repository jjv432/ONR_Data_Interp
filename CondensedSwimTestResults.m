clc
clear
close all
%% 3 Trials Files
AllCOT(1,:) = ["Experiment Name", "CoT", "average_power", "max_power_peak", "Mass"];
AllCOT2(1,:) = ["Experiment Name", "CoT", "average_power", "max_power_peak", "Mass"];
h = 2.65;
l = .675;
names_n_data = [

"experiment_09092024_1/walk_test_0_5Hz", 1.10, h; %all three trials %1
"experiment_09092024_1/walk_test_0_75Hz", 0.56, h; %2
"experiment_09092024_1/walk_test_1_5Hz", 1.05, h; %3
"experiment_09092024_1/walk_test_1_25Hz", 1.001, h; %4
"experiment_09092024_1/walk_test_1Hz", 0.96, h; %MISSING DATA on T1 %5
"experiment_09122024_1/obstacle_test_4", 1.068, l; %6 %

"experiment_09142024_1/walk_test_1_75Hz_2", 0.961, h; % 2
"experiment_09142024_1/walk_test_2_5Hz", 0.898, h; % 3
"experiment_09142024_1/walk_test_2Hz", 0.873, h; % 4
"experiment_09142024_1/walk_test_3_5Hz", 0.548, h; % 5
"experiment_09142024_1/walk_test_3Hz", 0.463, h; % 6
"experiment_09142024_1/walk_test_4Hz", 0.265, h; % 7

"experiment_09142024_1/swim_test_finsV1A", 0.263, h; % 1
"experiment_09142024_1/swim_test_finsV1b", 0.895, h; % 2
"experiment_09142024_1/swim_test_finsV1c", 0.723, h; % 3

];

Indexes = [

212 924 1562 2235 2682 3375;
139 662 998 1523 2035 2562;
279 548 1023 1292 1718 1986;
146 461 790 1105 1524 1837;
158 550 995 1389 1691 2081;
26 235 330 535 619 1057;
1 1 12 186 543 717; %First trial of this will be replaced by data later in this code
248 370 556 676 888 1010;
97 248 640 791 995 1143;
267 361 451 544 797 888;
354 456 542 644 889 991;
306 386 471 550 864 944;
160 274 372 473 572 683;
160 285 417 594 1016 1292;
209 307 454 587 1132 1243

];
k=1;

for a = 1:size(names_n_data, 1)
    clearvars -except names_n_data a AllCOT Indexes k swim_data_array h l 

    % swim_data = parseROSBag("experiment_09092024_1/joystick_test");
    swim_data_array(a) = parseROSBag(names_n_data(a,1));
    swim_data = swim_data_array(a);


    for z = 1:2:5
        beginningIndex = Indexes(a, z);
        endIndex = Indexes(a, z+1);
        % Power draw
        info0_time = swim_data.odrive0_info.Time(beginningIndex:endIndex);

        info0_trial_time = info0_time(end) - info0_time(1);
        info0_current = swim_data.odrive0_info.BusCurrent(beginningIndex:endIndex);
        info0_voltage = swim_data.odrive0_info.BusVoltage(beginningIndex:endIndex);
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
        AllCOT(k+1, :) = [names_n_data(a,1), CoT, average_power, max_power_peak, names_n_data(a,3)];
        fprintf('Average Cost of Transport = %0.2f \n\n',CoT);

        figure ()
        plot(info0_power)
        title(names_n_data(a,1))
        k=k+1;
    end
end



%%  1 Trial Files
names_n_data2 = [

"experiment_09122024_1/walk_test_0_1Hz", .777, l; %7
"experiment_09122024_1/walk_test_0_2Hz", 0.821, l; %8
"experiment_09122024_1/walk_test_0_5Hz", 0.707, l; %9
"experiment_09122024_1/walk_test_0_25Hz", 0.712, l; %10
"experiment_09122024_1/walk_test_0_35Hz", .288, l; %11
%Use this next one in place of the CoT that should come out as 0
"experiment_09142024_1/walk_test_1_75Hz", 0.750, h; % 1

];

Indexes2 = [

121 3121;
164 1164;
198 801;
95 896;
103 673;
144 317

];

for b = 1:size(names_n_data2, 1)
    clearvars -except names_n_data2 a AllCOT Indexes2 k swim_data_array h l b

    % swim_data = parseROSBag("experiment_09092024_1/joystick_test");
    swim_data = parseROSBag(names_n_data2(b,1));

    beginningIndex = Indexes2(b, 1);
    endIndex = Indexes2(b, 2);
    % Power draw
    info0_time = swim_data.odrive0_info.Time(beginningIndex:endIndex);

    info0_trial_time = info0_time(end) - info0_time(1);
    info0_current = swim_data.odrive0_info.BusCurrent(beginningIndex:endIndex);
    info0_voltage = swim_data.odrive0_info.BusVoltage(beginningIndex:endIndex);
    info0_power = info0_current .* info0_voltage;
    max_power_peak = max(info0_power);
    average_power = rms(info0_power);

    %Calculating CoT
    %d = 4.5;
    d = str2double(names_n_data2(b,2));
    %m = 2.65;
    m = str2double(names_n_data2(b,3));
    g = 9.81;

    fprintf("For experiment: %s\n", names_n_data2(b,1));
    fprintf(['Calculating with values: \n Distance = %0.1f \n Mass = %0.2f \n ' ...
        'Gravity = %0.2f \n Total Energy = %0.2f \n Trial Time = %0.2f \n'],d,m,g,average_power,info0_trial_time);

    info0_total_energy = average_power * info0_trial_time;

    CoT = info0_total_energy / (m*g*d);
    AllCOT(k+b, :) = [names_n_data2(b,1), CoT, average_power, max_power_peak, names_n_data2(b,3)];
    fprintf('Average Cost of Transport = %0.2f \n\n',CoT);

    figure ()
    plot(info0_time-info0_time(1), info0_power)
    title(names_n_data2(b,1))

end

