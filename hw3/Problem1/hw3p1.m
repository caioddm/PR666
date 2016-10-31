clear; clc;
addpath(genpath(pwd));
data = load('hw3p1_data.mat');
rows = data.rows;
cols = data.cols;
data = data.x;
samples = length(data(:,1));

%a) image of average face
figure
meanimg = mean(data, 1);
img = reshape(meanimg, rows, cols);
imagesc(img);
colormap gray;
title 'Image of average face';

%b) image of first six eigenvectors using the snapshot PCA
faces = data;
for idx=1:samples
    faces(idx, :) = faces(idx, :) - meanimg;
end

r = zeros(samples, samples);

for idx=1:samples
    for jdx=1:samples
        r(idx, jdx) = faces(idx, :) * transpose(faces(jdx, :));
    end
end

[reigenvectors, reigenvalues] = svd(r);

dimensions = 6;
eigenvectors = zeros(length(faces(1, :)), 6);
for idx=1:dimensions
    sum = zeros(1, length(faces(1, :)));
    for jdx = 1:samples
        sum = sum + reigenvectors(jdx, idx)*faces(jdx, :);
    end
    eigenvectors(:, idx) = sum;
end
figure('Position', [200 100 1024 800]);
for idx=1:dimensions    
    subplot(3,2,idx);
    img = reshape(eigenvectors(:, idx), rows, cols);
    imagesc(img);
    colormap gray;
    title(sprintf('Image PCA component #%d', idx));
end

%(c) scatter plot from the first two dimensions of PCA
figure('Position', [300 100 1024 800]);
pcavectors = faces * eigenvectors;
scatter(pcavectors(:, 1), pcavectors(:, 2));
hold on;
for idx = 1:samples
    imagesc(reshape(faces(idx, :), rows, cols), 'XData', [pcavectors(idx, 1) pcavectors(idx, 1)+60000000], 'YData', [pcavectors(idx, 2)  pcavectors(idx, 2)-50000000]);    
end
colormap gray;
title('Scatter plot of the first two PCA components');




