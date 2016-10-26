clear; clc;
addpath(genpath(pwd));
data = load('hw2p6_train.mat');
labels = data.clab1;
data = data.x1;

%computing PCA
covmatrix = cov(data);
[eigenvectors, eigenvalues] = svd(covmatrix);

%plot of the variance represented with the first N eigenvalues on PCA
eigenvalues = diag(eigenvalues);
sumeig = sum(eigenvalues);
totaleig = 0;
eigplot = [];
for idx = 1 : length(eigenvalues)
    totaleig = totaleig + eigenvalues(idx);    
    eigplot = [eigplot; log10(idx) totaleig/sumeig];
end
figure('Position', [100 100 1024 800]);
subplot(2,1,1);
plot(eigplot(:, 1), eigplot(:, 2));
ylabel('Percentage of variance represented');
xlabel('Components (log scaled)');
title('Amount of data variance captured with the first N components ');

pcavectors = data * eigenvectors(:, 1:4);
subplot(2, 1, 2);
hold on;
scatter3(pcavectors(:, 1), pcavectors(:, 2), pcavectors(:, 3), 0.001);
idxs1 = labels(:, 1) == 1;
pca1 = pcavectors(idxs1, :);
text(pca1(:,1), pca1(:,2), pca1(:,3), '1', 'color', 'b');
idxs2 = labels(:, 1) == 2;
pca2 = pcavectors(idxs2, :);
text(pca2(:,1), pca2(:,2), pca2(:,3), '2', 'color', 'r');
idxs3 = labels(:, 1) == 3;
pca3 = pcavectors(idxs3, :);
text(pca3(:,1), pca3(:,2), pca3(:,3), '3', 'color', 'g');
title('Scatter plot of the first three PCA components');
grid on;
hold off;

%plot of the class separability represented with the first N eigenvalues on
%LDA
[y, v, d] = tamu_lda(data, labels);
sumeig = sum(d);
totaleig = 0;
eigplot = [];
for idx = 1 : length(d)
    totaleig = totaleig + d(idx);    
    eigplot = [eigplot; idx totaleig/sumeig];
end
figure('Position', [200 100 1024 800]);
subplot(2, 1, 1);
plot(eigplot(:, 1), eigplot(:, 2));
ylabel('Percentage of class separability represented');
xlabel('# of Eigenvalues');
title('Amount of class separability info captured with the first N Eigenvalues ');

subplot(2, 1, 2);
hold on;
scatter(y(:, 1), y(:, 2), 0.001);
lda1 = y(idxs1, :);
text(lda1(:,1), lda1(:,2), '1', 'color', 'b');
lda2 = y(idxs2, :);
text(lda2(:,1), lda2(:,2), '2', 'color', 'r');
lda3 = y(idxs3, :);
text(lda3(:,1), lda3(:,2), '3', 'color', 'g');
title('2-D Scatter plot of LDA projections');
hold off;



%(b) experiment with different classification approaches
%compute quadratic classifier
accuq = [];
accuqp = [];
accuql = [];
set1 = data(idxs1, :);
set2 = data(idxs2, :);
set3 = data(idxs3, :);
for k = 1 : 30
    [train1, test1] = GetRandomSets(set1, 1/4);
    [train2, test2] = GetRandomSets(set2, 1/4);
    [train3, test3] = GetRandomSets(set3, 1/4);
    accuq = [accuq; ClassifyQuadratic(train1, test1, train2, test2, train3, test3)];
    
    %computing PCA with training data  
    
    %classifying data in a 50-D PCA
    covmatrix = cov([train1; train2; train3]);
    [eigenvectors, eigenvalues] = svd(covmatrix);
    pcavectrain1 = train1 * eigenvectors(:, 1:50);
    pcavectest1 = test1 * eigenvectors(:, 1:50);

    pcavectrain2 = train2 * eigenvectors(:, 1:50);
    pcavectest2 = test2 * eigenvectors(:, 1:50);

    pcavectrain3 = train3 * eigenvectors(:, 1:50);
    pcavectest3 = test3 * eigenvectors(:, 1:50);
    accuqp = [accuqp; ClassifyQuadratic(pcavectrain1, pcavectest1, pcavectrain2, pcavectest2, pcavectrain3, pcavectest3)];
    
    
    %classifying data using LDA
    l1(1:length(train1(:,1))) = 1;
    train1 = [train1, transpose(l1)];
    l2(1:length(train2(:,1))) = 2;
    train2 = [train2, transpose(l2)];
    l3(1:length(train3(:,1))) = 3;
    train3 = [train3, transpose(l3)];    
    dataset = [train1; train2; train3];

    [y, v, d] = tamu_lda(dataset(:,1:end-1), dataset(:, end));
    ldatrain1 = train1(:, 1:end-1) * v;
    ldatest1 = test1 * v;

    ldatrain2 = train2(:, 1:end-1) * v;
    ldatest2 = test2 * v;

    ldatrain3 = train3(:, 1:end-1) * v;
    ldatest3 = test3 * v;
    accuql = [accuql; ClassifyQuadratic(ldatrain1, ldatest1, ldatrain2, ldatest2, ldatrain3, ldatest3)];
end

disp('Quadratic classifier results');
fprintf('Mean accuracy for original space: %f', mean(accuq));
disp(' ');
fprintf('Mean accuracy for 50-D PCA space: %f', mean(accuqp));
disp(' ');
fprintf('Mean accuracy for 2-D LDA space: %f', mean(accuql));
disp(' ');

%compute accuracy using knn classifier
accuk = [];
accukp = [];
accukl = [];
disp('KNN classifier results');
for idx = 0 : 10
    k = 2*idx + 1;
    for j = 1 : 30
        [train1, test1] = GetRandomSets(set1, 1/4);
        [train2, test2] = GetRandomSets(set2, 1/4);
        [train3, test3] = GetRandomSets(set3, 1/4);
        accuk = [accuk; ClassifyKnn(k, train1, test1, train2, test2, train3, test3)];

        %computing PCA with training data    
        covmatrix = cov([train1; train2; train3]);
        [eigenvectors, eigenvalues] = svd(covmatrix);
        pcavectrain1 = train1 * eigenvectors(:, 1:50);
        pcavectest1 = test1 * eigenvectors(:, 1:50);

        pcavectrain2 = train2 * eigenvectors(:, 1:50);
        pcavectest2 = test2 * eigenvectors(:, 1:50);

        pcavectrain3 = train3 * eigenvectors(:, 1:50);
        pcavectest3 = test3 * eigenvectors(:, 1:50);
        accukp = [accukp; ClassifyKnn(k, pcavectrain1, pcavectest1, pcavectrain2, pcavectest2, pcavectrain3, pcavectest3)];


        %classifying data using LDA
        l1(1:length(train1(:,1))) = 1;
        train1 = [train1, transpose(l1)];
        l2(1:length(train2(:,1))) = 2;
        train2 = [train2, transpose(l2)];
        l3(1:length(train3(:,1))) = 3;
        train3 = [train3, transpose(l3)];

        dataset = [train1; train2; train3];

        [y, v, d] = tamu_lda(dataset(:,1:end-1), dataset(:, end));
        ldatrain1 = train1(:, 1:end-1) * v;
        ldatest1 = test1 * v;

        ldatrain2 = train2(:, 1:end-1) * v;
        ldatest2 = test2 * v;

        ldatrain3 = train3(:, 1:end-1) * v;
        ldatest3 = test3 * v;
        accukl = [accukl; ClassifyKnn(k, ldatrain1, ldatest1, ldatrain2, ldatest2, ldatrain3, ldatest3)];
    end
    fprintf('Results for K = %d', k);
    disp(' ');
    fprintf('Mean accuracy for original space: %f', mean(accuk));
    disp(' ');
    fprintf('Mean accuracy for 50-D PCA space: %f', mean(accukp));
    disp(' ');
    fprintf('Mean accuracy for 2-D LDA space: %f', mean(accukl));
    disp(' ');
    disp(' ');
end








