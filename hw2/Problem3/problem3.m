clear; clc;
addpath(genpath(pwd));

%generating the three sets
mean_vector1 = [5; 0; 5];
cov_matrix1 = [5 -4 -2; -4 4 0; -2 0 5];

set1 = mvnrnd(mean_vector1, cov_matrix1, 250);

mean_vector2 = [4; 6; 7];
cov_matrix2 = [3 0 0; 0 3 0; 0 0 3];

set2 = mvnrnd(mean_vector2, cov_matrix2, 250);

mean_vector3 = [6; 2; 4];
cov_matrix3 = [6 5 6; 5 6 7; 6 7 9];

set3 = mvnrnd(mean_vector3, cov_matrix3, 250);

%adding noise to the sets
noise1 = normrnd(1, 6, 250, 48);
set1 = [set1, noise1];
noise2 = normrnd(1, 6, 250, 48);
set2 = [set2, noise2];
noise3 = normrnd(1, 6, 250, 48);
set3 = [set3, noise3];

figure('Position', [100 100 1024 800]);
subplot(2,1,1);
hold on
%(a) compute first two PCA components and plot scatter
covmatrix = cov([set1;set2;set3]);
[eigenvectors, eigenvalues] = svd(covmatrix);
pcavectors1 = set1 * eigenvectors(:, 1:2);
text(pcavectors1(:,1), pcavectors1(:,2), '1', 'color', 'b');
scatter(pcavectors1(:,1), pcavectors1(:,2), 0.01);

pcavectors2 = set2 * eigenvectors(:, 1:2);
text(pcavectors2(:,1), pcavectors2(:,2), '2', 'color', 'r');
scatter(pcavectors2(:,1), pcavectors2(:,2), 0.01);

pcavectors3 = set3 * eigenvectors(:, 1:2);
text(pcavectors3(:,1), pcavectors3(:,2), '3', 'color', 'g');
scatter(pcavectors3(:,1), pcavectors3(:,2), 0.01);
title('2-D scatter of the first two components of PCA');
hold off

%(b) compute LDA and plot scatter
l1(1:250) = 1;
set1 = [set1, transpose(l1)];
l2(1:250) = 2;
set2 = [set2, transpose(l2)];
l3(1:250) = 3;
set3 = [set3, transpose(l3)];
dataset = [set1; set2; set3];

[y, v, d] = tamu_lda(dataset(:,1:end-1), dataset(:, end));

subplot(2,1,2);
hold on
text(y(1:250,1), y(1:250,2), '1', 'color', 'b');
scatter(y(1:250,1), y(1:250,2), 0.01);
text(y(251:500,1), y(251:500,2), '2', 'color', 'r');
scatter(y(251:500,1), y(251:500,2), 0.01);
text(y(501:750,1), y(501:750,2), '3', 'color', 'g');
scatter(y(501:750,1), y(501:750,2), 0.01);
title('2-D scatter using LDA')
hold off
