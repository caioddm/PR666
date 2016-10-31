clear; clc;
addpath(genpath(pwd));
%load training data
data = load('hw3p4_train.mat');
train_labels = data.clab1;
train_data = data.x1;
train_data = [train_data, train_labels];


%load test data
data = load('hw3p4_test.mat');
test_labels = data.clab2;
test_data = data.x2;
test_data = [test_data, test_labels];


features_idx = [6 25 32 27 1 8 33 29 18 10];
train_data = [train_data(:, features_idx), train_data(:, end)];
test_data = [test_data(:, features_idx), test_data(:, end)];
uclab = zeros(length(test_data(:,1)), 1);
for j = 1 : length(test_data(:,1))    
    class = KnnClassifier(train_data, 5, test_data(j,1:end-1), 10);
    %append assigned class into the uclab col vector
    uclab(j, 1) = class;
end

%validate results comparing with the correct classes
%correct = test_labels(:,1) == uclab(:,1);
%correct = sum(correct)/length(uclab(:,1));
%fprintf('Classification accuracy: %f\n', correct);

disp('uclab = [');
disp(uclab);
disp('];')