clear; clc;
addpath(genpath(pwd));

parts = dir('parts/*.jpg'); 

lbs = [];
features = zeros(40, 4);
%get the labels of each image
for idx = 1:length(parts)
        imgname = parts(idx).name;
        lbs = [lbs; strcat(imgname(1),num2str(mod(idx, 10)))];
end
%extract each feature
features(:,1) = extractBoundingBoxWidth(parts);
features(:,2) = extractBoundingBoxHeight(parts);
features(:,3) = extractAreas(parts);
features(:,4) = extractPixelIntensityAverage(parts);

%Generate scatter plots of each feature pair
figure('Name', 'Scatter plots for each feature pair', 'Position', [100 200 1600 800]);
subplot(2,3,1);
scatter(features(:,1), features(:,2), 'filled');
labels = lbs;
text(features(:,1), features(:,2), labels, 'horizontal','left', 'vertical','bottom');
title('F1 vs F2');

subplot(2,3,2);
scatter(features(:,1), features(:,3), 'filled');
labels = lbs;
text(features(:,1), features(:,3), labels, 'horizontal','left', 'vertical','bottom');
title('F1 vs F3');

subplot(2,3,3);
scatter(features(:,1), features(:,4), 'filled');
labels = lbs;
text(features(:,1), features(:,4), labels, 'horizontal','left', 'vertical','bottom');
title('F1 vs F4');

subplot(2,3,4);
scatter(features(:,2), features(:,3), 'filled');
labels = lbs;
text(features(:,2), features(:,3), labels, 'horizontal','left', 'vertical','bottom');
title('F2 vs F3');

subplot(2,3,5);
scatter(features(:,2), features(:,4), 'filled');
labels = lbs;
text(features(:,2), features(:,4), labels, 'horizontal','left', 'vertical','bottom');
title('F2 vs F4');

subplot(2,3,6);
scatter(features(:,3), features(:,4), 'filled');
labels = lbs;
text(features(:,3), features(:,4), labels, 'horizontal','left', 'vertical','bottom');
title('F3 vs F4');