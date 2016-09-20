clear; clc;
addpath(genpath(pwd));

parts = dir('parts/*.jpg'); 
features = zeros(40, 4);
features(:,1) = extractBoundingBoxWidth(parts);
features(:,2) = extractBoundingBoxHeight(parts);
features(:,3) = extractAreas(parts);
features(:,4) = extractPixelIntensityAverage(parts);
distances = zeros(40,40);
distances2 = zeros(40,40);
vectorizedImgs = zeros(40, 1024);

for idx = 1:length(parts)
    [out1, map1] = imresize(imread(parts(idx).name), [32 32]);
    vectorizedImgs(idx, :) = vectorizedImg(out1);
end


for idx = 1:length(parts)
    for idx2 = 1:length(parts)
        distances(idx, idx2) = pdist2(vectorizedImgs(idx, :), vectorizedImgs(idx2, :));
        distances2(idx, idx2) = pdist2(features(idx, :), features(idx2, :));
    end
end

figure('Name', 'Color pixels Euclidian distances', 'Position', [100 200 600 600]);
imagesc(distances);

figure('Name', 'Extracted features distances', 'Position', [900 200 600 600]);
imagesc(distances2);
