%% Improved CoT

%% Creating the intial plots to get index numbers

clc
clearvars -except AllSwimData AllNumTrials AllIndices AllPower
close all
%%
k = 1;
AllCOT(k,:) = ["Experiment Name", "CoT", "average_power", "max_power_peak", "Apparent Weight"];
h = 2.65;
l = .675;

%Single example for now; make struct later (use cd / ls cmds to auto?
bag_relative_path = "../../SELQIE-Experiments/rosbags/";
experiment_names = "experiment_09122024_1";
test_names = "obstacle_test_3";


names_n_data = [
    "../../rosbags/experiment_09092024_1", 1, l;
    ];

%% Getting frames

frameBool = input("Do you need to collect frames (y/n)?\n", 's');

if (frameBool == 'y' || frameBool == 'Y')
    for a = 1:size(names_n_data, 1)

        swim_data = parseROSBag(names_n_data(a,1), "/walk_test_1_25Hz");
        AllSwimData.a = swim_data;

        % Power draw
        info0_current = swim_data.odrive0_info.BusCurrent;
        info0_voltage = swim_data.odrive0_info.BusVoltage;
        info0_power = info0_current .* info0_voltage;

        [Indices, NumTrials] = indexParser(1:length(info0_power), info0_power);
        AllIndices.a = Indices;
        AllNumTrials.a = NumTrials;
        AllPower.a = info0_power;
        close all;

    end
end
%% Calculating CoT

for a = 1:size(names_n_data, 1)

    swim_data = AllSwimData.a;
    NumTrials = AllNumTrials.a;

    Indices = AllIndices.a;

    figure ()

    hold on


    for z = 1:2:2*NumTrials
        beginningIndex = Indices(z);
        endIndex = Indices(z+1);
        % Power draw
        info0_time = swim_data.odrive0_info.Time(beginningIndex:endIndex);

        info0_trial_time = info0_time(end) - info0_time(1);

        info0_power = AllPower.a(beginningIndex:endIndex);
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

        title(strcat("Experiment", num2str(a)));
        subplot(NumTrials, 1, ((z-1)/2 + 1))
        plot(info0_power)
        legend(strcat('Trial', num2str((z-1)/2 + 1)))
        k=k+1;
    end

    hold off
end
