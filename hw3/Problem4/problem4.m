clear; clc;
addpath(genpath(pwd));
data = load('hw3p4_train.mat');
labels = data.clab1;
data = data.x1;
data = [data, labels];


%replace missing features with averages
% for col=1:46
%     vals = data(data(:, col) ~= -1,col);
%     m = mean(vals);
%     data(data(:, col) == -1, col) = m;
% end


features_available = 1:46;
features_available = [features_available; ones(1, 46)];
features_idx = [];
lcount = 2;
while (length(features_idx) < 10)
    fprintf('currently with %d feature(s)\n', length(features_idx));
    best_feature = -1;
    best_val = -Inf;
    best_accuk = [];
    for feat=features_available(1, features_available(2,:) == 1)
        tmp_features_idx = [features_idx, feat];
        [accuk, accuq] = EvaluateFeatures(data, tmp_features_idx);
        res = accuk;
        if(res > best_val)
            best_val = res;
            best_feature = feat;
            best_accuk = accuk;
        end
    end
    features_available(2, best_feature) = 0;
    features_idx = [features_idx, best_feature];
    lcount = lcount - 1;
    %remove feature
    if(lcount == 0)
        lcount = 2;
        worst_feature = -1;
        best_val = -Inf;
        for feat=features_available(1, features_available(2,:) == 0)
            tmp_features_idx = features_idx(1 ,features_idx(1, :)~=feat);
            [accuk, accuq] = EvaluateFeatures(data, tmp_features_idx);
            res = accuk;
            if(res > best_val)
                best_val = res;
                worst_feature = feat;
                best_accuk = accuk;
            end
        end
        features_available(2, worst_feature) = 1;
        features_idx = features_idx(1 ,features_idx(1, :)~=worst_feature);
    end
    disp('Features selected');
    disp(features_idx);
    disp(' ');
    disp('Accuracy for K = 5');
    disp(best_accuk);
    disp(' ');    
end

disp('Features selected');
disp(features_idx);
disp(' ');

for range=1:length(features_idx)
    [accuk, accuq] = EvaluateFeatures(data, features_idx);
    fprintf('Features 1 to %d\n', range);
    disp(accuk);
end



function [accuk, accuq] = EvaluateFeatures(data, features_idx)
    accuk = [];
    accuq = [];
    num_classes = 10;
    for it=1:5
        trainset = [];
        testset = [];
        for c=1:num_classes
            rows = data(data(:, end) == c, :);
            [train, test] = GetRandomSets(rows, 1/4);
            trainset = [trainset; train];
            testset = [testset; test];
        end
        trainset = [trainset(:, features_idx), trainset(:, end)];
        testset = [testset(:, features_idx), testset(:, end)];
        accuk = [accuk; ClassifyKnn(5, trainset, testset, num_classes)];
        accuq = [accuq; ClassifyQuadratic(trainset, testset, num_classes)];    
    end
%     fprintf('Mean accuracy for Knn (5, 10, and 20 K size):');
%     disp(' ');
%     disp(mean(accuk));
%     fprintf('Mean accuracy for Quadratic: %f', mean(accuq));
%     disp(' ');
    accuk = mean(accuk);
    accuq = mean(accuq);
end

function [ train, test ] = GetRandomSets( data, ratio )
numsamples = floor(length(data(:,1))*ratio);
randomidxs = randperm(length(data(:,1)));

train = zeros(length(data(:,1)) - numsamples, length(data(1, :)));
test = zeros(numsamples, length(data(1, :)));
testidx = 1;
trainidx = 1;
for i = 1 : length(data(:,1))
    if(i <= numsamples)
        test(testidx, :) = data(randomidxs(i), :);
        testidx = testidx + 1;
    else
        train(trainidx, :) = data(randomidxs(i), :);
        trainidx = trainidx + 1;
    end
end

end