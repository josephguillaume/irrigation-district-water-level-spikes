%% Detect Spikes
%% SK Ooi Mar 2024

clear all

%%
%%% using NON uniform data points
%%
%%% Simply compare with previous data point!%%%

% % Load data from .mat file
file_name = '';
load(file_name)

%% Find certain month data points

index=find(month(unique_time)==1);

% % specify the period of the data
starttime=index(1);
endtime=index(end);
data=unique_data(starttime:endtime);
time=unique_time(starttime:endtime);

%%
% Set parameters for spike detection
threshold = 0.1;     % Adjust this threshold as needed


% Set a threshold for the time interval
% Bigger --> less strict
time_threshold = minutes(10);  % Adjust this time threshold as needed
% time_threshold = minutes(5);  % Adjust this time threshold as needed

%%

% % Initialize an empty array to store spike indices
spike_indices = [];

% Iterate through the time series to detect spikes
for i = 2:length(data)
    time_interval = time(i) - time(i-1);
    if abs(data(i) - data(i-1)) > threshold && time_interval < time_threshold
        spike_indices = [spike_indices, i];
    end
end

% Plot the time series, moving average, and highlight spike points
figure;
plot(time, data, 'b-o','MarkerSize',2);
hold on;
scatter(time(spike_indices), data(spike_indices), 'r', 'filled');
xlabel('Time');
ylabel('U/S water level');
title(['Spike Detection compare previous. Threshold = ', num2str(threshold), ', Time Threshold = ', char(time_threshold)],file_name(1:4));
legend('U/S water level','Spikes detected')
grid on
hold off


% % Display spike indices
% disp('Spike Indices:');
% disp(spike_indices);
