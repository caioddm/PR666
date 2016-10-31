clear; clc;
addpath(genpath(pwd));
data = load('us_city_distance.mat');
distances = data.d;
names = data.names;

%performing isomap on the us cities distances
embedding = isomap(distances, 3);

figure('Position', [100 100 1024 800]);
subplot(1,2,1);
scatter3(embedding(:, 1), embedding(:, 2), embedding(:, 3));
hold on;
for idx=1:10:length(names(:,1))
    text(embedding(idx, 1), embedding(idx, 2), embedding(idx, 3), names(idx, :));
end
hold off;
title '3-D Scatterplot for US cities'

subplot(1,2,2);
scatter(embedding(:, 1), embedding(:, 2));
hold on;
for idx=1:10:length(names(:,1))
    text(embedding(idx, 1), embedding(idx, 2), names(idx, :));
end
hold off;
title '2-D Scatterplot for US cities'

%performing isomap on the word cities distances
data = load('world_city_distance.mat');
distances = data.d;
names = data.names;

embedding = isomap(distances, 3);
figure('Position', [300 100 1024 800]);
subplot(1,2,1);
scatter3(embedding(:, 1), embedding(:, 2), embedding(:, 3));
hold on;
for idx=1:10:length(names(:,1))
    text(embedding(idx, 1), embedding(idx, 2), embedding(idx, 3), names(idx, :));
end
hold off;
title '3-D Scatterplot for world cities'

subplot(1,2,2);
scatter(embedding(:, 1), embedding(:, 2));
hold on;
for idx=1:10:length(names(:,1))
    text(embedding(idx, 1), embedding(idx, 2), names(idx, :));
end
hold off;
title '2-D Scatterplot for world cities'