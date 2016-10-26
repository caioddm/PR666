clear; clc;
addpath(genpath(pwd));
%load training data
data = load('hw2p6_train.mat');
train_labels = data.clab1;
train_data = data.x1;

%load test data
data = load('hw2p6_test.mat');
test_labels = data.clab2;
test_data = data.x2;

%group train data according to labels
train_idxs1 = train_labels(:, 1) == 1;
train_idxs2 = train_labels(:, 1) == 2;
train_idxs3 = train_labels(:, 1) == 3;
train1 = train_data(train_idxs1, :);
train2 = train_data(train_idxs2, :);
train3 = train_data(train_idxs3, :);

%create training dataset with the last column as the class label
l1(1:length(train1(:,1))) = 1;
train1 = [train1, transpose(l1)];
l2(1:length(train2(:,1))) = 2;
train2 = [train2, transpose(l2)];
l3(1:length(train3(:,1))) = 3;
train3 = [train3, transpose(l3)];    
dataset = [train1; train2; train3];
%compute LDA for the training dataset
[y, v, d] = tamu_lda(dataset(:,1:end-1), dataset(:, end));
%project each class points using the LDA eigenvectors
ldatrain1 = train1(:, 1:end-1) * v;
ldatrain2 = train2(:, 1:end-1) * v;
ldatrain3 = train3(:, 1:end-1) * v;

%project the test data using the LDA eigenvectors
ldatest = test_data * v;
uclab = [];
%classify the test point using a quadratic classifier
%point is assigned to the class with the highest value
totalLength = [ldatrain1 ; ldatrain2; ldatrain3];
totalLength = length(totalLength(:,1));
prior1 = length(ldatrain1(:,1))/totalLength;
prior2 = length(ldatrain2(:,1))/totalLength;
prior3 = length(ldatrain3(:,1))/totalLength;
for j = 1 : length(ldatest(:,1))
    val1 = QuadraticClassifier(ldatrain1, ldatest(j,:), prior1);
    val2 = QuadraticClassifier(ldatrain2, ldatest(j,:), prior2);
    val3 = QuadraticClassifier(ldatrain3, ldatest(j,:), prior3);
    [val, class] = max([val1; val2; val3]);
    %append assigned class into the uclab col vector
    uclab = [uclab; class];
end

%validate results comparing with the correct classes
%correct = test_labels(:,1) == uclab(:,1);
%correct = sum(correct)/length(uclab(:,1));
%fprintf('Classification accuracy: %f\n', correct);

disp('uclab = [');
disp(uclab);
disp('];')