clear; clc;
addpath(genpath(pwd));
data = load('hw2p2_data.mat');
data = data.x;


%(a) generate scatter plot from first three dimensions
figure;
scatter3(data(:, 1), data(:, 2), data(:, 3))

%get the covariance matrix from the data
covmatrix = cov(data);

%get eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = svd(covmatrix);

%(b) plot of the eigenvalues sorted in descending order
eigenvalues = diag(eigenvalues);
sumeig = sum(eigenvalues);
totaleig = 0;
eigplot = [];
for idx = 1 : 400
    totaleig = totaleig + eigenvalues(idx);
    eigplot = [eigplot; idx totaleig/sumeig];
end
figure;
plot(eigplot(:, 1), eigplot(:, 2));

%(c) scatter plot from the first three dimensions of PCA
figure;
pcavectors = eigenvectors(:, 1:3);
scatter3(pcavectors(:, 1), pcavectors(:, 2), pcavectors(:, 3))


