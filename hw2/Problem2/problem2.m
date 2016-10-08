clear; clc;
addpath(genpath(pwd));
data = load('hw2p2_data.mat');
data = data.x;


%(a) generate scatter plot from first three dimensions
figure('Position', [100 100 1024 800]);
scatter3(data(:, 1), data(:, 2), data(:, 3))

%get the covariance matrix from the data
covmatrix = cov(data);

%get eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = svd(covmatrix);

%(b) plot of the eigenvalues sorted in descending order
figure('Position', [200 100 1024 800]);

eigenvalues = diag(eigenvalues);
sumeig = sum(eigenvalues);
totaleig = 0;
eigplot = [];
for idx = 1 : 400
    totaleig = totaleig + eigenvalues(idx);    
    eigplot = [eigplot; log10(idx) eigenvalues(idx) totaleig/sumeig];
end
subplot(2, 1, 1);
plot(eigplot(:, 1), eigplot(:, 2));
ylabel('Eigenvalue');
xlabel('Component (log scaled)');
title('Eigenvalues of each component');

subplot(2, 1, 2);
plot(eigplot(:, 1), eigplot(:, 3));
ylabel('Percentage of variance represented');
xlabel('Components (log scaled)');
title('Amount of data variance captured with the first N components ');

%(c) scatter plot from the first three dimensions of PCA
figure('Position', [300 100 1024 800]);
pcavectors = data * eigenvectors(:, 1:4);
subplot(2, 1, 1);
scatter3(pcavectors(:, 1), pcavectors(:, 2), pcavectors(:, 3));
title('Scatter plot of the first three PCA components');

subplot(2, 1, 2);
scatter3(pcavectors(:, 2), pcavectors(:, 3), pcavectors(:, 4))
title('Scatter plot of second, third, and fourth PCA components')

