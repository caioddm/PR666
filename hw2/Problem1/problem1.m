clear; clc;
addpath(genpath(pwd));
data = load('hw2p1_data.mat');
data = data.x;

minval = min(data);
maxval = max(data);

range = (-15:1:84);
bandwith = 0.5;
kde = [];

for idx = 1 : length(range)
    step = range(idx);
    val = ComputeKDE(step, data, bandwith);
    kde = [kde; val];
end


histogram(data, 50, 'Normalization','pdf');
hold on
plot(range, kde, 'red', 'LineWidth', 1);
hold off
