clear; clc;
addpath(genpath(pwd));
data = load('hw1p4_data.mat');
data = data.x;

%(1) Generating scatter plots for each pair of features
figure('Name', 'Scatter for pair of features', 'Position', [100 200 800 800]);
subplot(3,1,1);
scatter(data(:,1), data(:,2), 10, 'filled');
title('F1 vs F2');

subplot(3,1,2);
scatter(data(:,2), data(:,3), 10, 'filled');
title('F2 vs F3');

subplot(3,1,3);
scatter(data(:,1), data(:,3), 10, 'filled');
title('F1 vs F3');

%(2) Mean vector and covariance matrix
mean_vector = mean(data);
cov_matrix = cov(data);
disp('Mean vector:');
disp(mean_vector);
disp('Covariance matrix:');
disp(cov_matrix);

%(3) Gaussian dataset generated from the mean vector and covariance matrix
set = mvnrnd(mean_vector, cov_matrix, 4996);

%(4) Generating scatter plots for each pair of features on the gaussian
%dataset
figure('Name', 'Scatter for pair of features on the Gaussian dataset', 'Position', [900 200 800 800]);
subplot(3,1,1);
scatter(set(:,1), set(:,2), 10, 'filled');
title('F1 vs F2');

subplot(3,1,2);
scatter(set(:,2), set(:,3), 10, 'filled');
title('F2 vs F3');

subplot(3,1,3);
scatter(set(:,1), set(:,3), 10, 'filled');
title('F1 vs F3');