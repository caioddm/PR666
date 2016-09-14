addpath(genpath(pwd));

parts = dir('parts/*.jpg'); 

lbs = [];
features = zeros(40, 4);
for idx = 1:length(parts)
        imgname = parts(idx).name;
        lbs = [lbs; strcat(imgname(1),num2str(mod(idx, 10)))];
end
features(:,1) = extractBoundingBoxWidth(parts);
features(:,2) = extractBoundingBoxHeight(parts);
features(:,3) = extractAreas(parts);
features(:,4) = extractPixelIntensityAverage(parts);

vec = vectorizedFeatures(features);

figure('Name', 'F1 vs F2');
scatter(features(:,1), features(:,2), 'filled');
%axis([0 1 0 1])
labels = lbs;    %'
text(features(:,1), features(:,2), labels, 'horizontal','left', 'vertical','bottom');

figure('Name', 'F1 vs F3');
scatter(features(:,1), features(:,3), 'filled');
%axis([0 1 0 1])
labels = lbs;    %'
text(features(:,1), features(:,3), labels, 'horizontal','left', 'vertical','bottom');

figure('Name', 'F1 vs F4');
scatter(features(:,1), features(:,4), 'filled');
%axis([0 1 0 1])
labels = lbs;    %'
text(features(:,1), features(:,4), labels, 'horizontal','left', 'vertical','bottom');

figure('Name', 'F2 vs F3');
scatter(features(:,2), features(:,3), 'filled');
%axis([0 1 0 1])
labels = lbs;    %'
text(features(:,2), features(:,3), labels, 'horizontal','left', 'vertical','bottom');

figure('Name', 'F2 vs F4');
scatter(features(:,2), features(:,4), 'filled');
%axis([0 1 0 1])
labels = lbs;    %'
text(features(:,2), features(:,4), labels, 'horizontal','left', 'vertical','bottom');

figure('Name', 'F3 vs F4');
scatter(features(:,3), features(:,4), 'filled');
%axis([0 1 0 1])
labels = lbs;    %'
text(features(:,3), features(:,4), labels, 'horizontal','left', 'vertical','bottom');