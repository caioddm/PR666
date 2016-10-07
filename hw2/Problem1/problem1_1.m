clear; clc;
addpath(genpath(pwd));
data = load('hw2p1_data.mat');
data = data.x;

%get range of data
minval = min(data);
maxval = max(data);

range = (-15:1:84);
bandwith = [0.1 0.8 5]; %small, best, and large bandwiths
kde = [];

figure('Position', [100 100 1024 800]);
for j = 1 : length(bandwith) %compute the KDE for each bandwith
    kde = [];
    subplot(3, 1, j);    
    for idx = 1 : length(range)
        step = range(idx);
        val = ComputeKDE(step, data, bandwith(j));
        kde = [kde; val];
    end    
    histogram(data, 50, 'Normalization','pdf'); %plot histogram
    hold on
    plot(range, kde, 'red', 'LineWidth', 1); %plot kde on top of histogram
    hold off
    ylabel('density');
    xlabel('x');
    title(sprintf('Gaussian KDE with bandwith of %f', bandwith(j)));
end


