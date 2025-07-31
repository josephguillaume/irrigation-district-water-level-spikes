%% S K Ooi Feb 2024
%% Extract data required for spikes detection from the raw data (csv file)
clear all

% Specify the path and name of the CSV file
% Data provided are upstream and downstream water level, gate elevation, flow, control mode and sensor status.
% 
file_name = ''
 
%% Use the readtable function to read the data
% data = readtable([file_path,file_name]);
data = readtable(file_name);

% Access the date and time column as datetime objects
date_time = datetime(data{:, 1}, 'InputFormat', 'dd-mm-yyyy HH:mm:ss'); 
% Modify the format as per the data

% Access the data points from the second column
data_points = data{:, 2};

% % Display the datetime and data points
% disp(date_time);
% disp(data_points);

%% % Remove repeated date and time data points before interpolate
[unique_time, indexnew, indexold] = unique(date_time);
unique_data = data_points(indexnew);

save([file_name(1:end-4),'.mat'], 'data_points', 'date_time', "unique_time", "unique_data")

end