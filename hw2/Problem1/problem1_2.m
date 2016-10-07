clear; clc;
addpath(genpath(pwd));
data = load('hw2p1_data.mat');
data = data.x;

%compute bandwith h0
sigma = std(data);
iqrval = iqr(data);
a = min(sigma, iqrval/1.34);
h0 = 0.9*a*(length(data)^(-1/5))

logspacestart = log10(h0) - 2;
logspaceend = log10(h0) + 2;

range = logspace(logspacestart, logspaceend, 100);
plotdata = [];

highestlog = -Inf;
highestbandwith = -1;
%compute the average log likelihoods for each one of the hundred bandwiths
for j = 1 : length(range)
    bandwith = range(j);
    loglike = 0;
    %compute the average log likelihood using leave-one-out approach
    for idx = 1 : length(data)
        test = data(idx);
        training = data;
        training = training([1:idx-1 idx+1:end]);
        loglike = loglike + log(ComputeKDE(test, training, bandwith));
    end
    loglike = loglike/length(data);
    if(loglike > highestlog)
        highestlog = loglike;
        highestbandwith = bandwith;
    end
    plotdata = [plotdata; log(bandwith) loglike];
end

%average log likelihood plot
figure('Position', [100 100 1024 800]);
kde = [];
subplot(2, 1, 1);    
plot(plotdata(:, 1), plotdata(:, 2), 'red', 'LineWidth', 1); 
ylabel('log-likelihood');
xlabel('bandwith');
title('Log-likelihoods vs. bandwith');

%plot kde with the highest log likelihood and the one with the plugin
%value, along with the histogram
range = (-15:1:84);
kdebest = [];
kdeplug = [];
subplot(2, 1, 2);    
for idx = 1 : length(range)
    step = range(idx);
    valbest = ComputeKDE(step, data, highestbandwith);
    valplug = ComputeKDE(step, data, h0);
    kdebest = [kdebest; valbest];
    kdeplug = [kdeplug; valplug];
end    
histogram(data, 50, 'Normalization','pdf'); %plot histogram
hold on
plot(range, kdebest, 'red', 'LineWidth', 1); %plot kde of the bandwith with the highest likelihood on top of histogram
plot(range, kdeplug, 'blue', 'LineWidth', 1); %plot kde of the plug in bandwith on top of histogram
hold off
ylabel('density');
xlabel('x');
title('Gaussian KDEs with the highest log-likelihood and plug-in bandwiths');



