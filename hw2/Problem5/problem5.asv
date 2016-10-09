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


%compute knn classifier for the high dimensional space
accuk = [];
accup = [];
accul = [];
for idx = 0 : 10
    k = 2*idx + 1;
    for j = 1 : 30
        [train1, test1] = GetRandomSets(set1, 1/4);
        [train2, test2] = GetRandomSets(set2, 1/4);
        [train3, test3] = GetRandomSets(set3, 1/4);
        accuk = [accuk; Classify(k, train1, test1, train2, test2, train3, test3)];

        %computing PCA with training data    
        covmatrix1 = cov(train1);
        [eigenvectors1, eigenvalues1] = svd(covmatrix1);
        pcavectrain1 = train1 * eigenvectors1(:, 1:2);
        pcavectest1 = test1 * eigenvectors1(:, 1:2);

        covmatrix2 = cov(train2);
        [eigenvectors2, eigenvalues2] = svd(covmatrix2);
        pcavectrain2 = train2 * eigenvectors2(:, 1:2);
        pcavectest2 = test2 * eigenvectors2(:, 1:2);

        covmatrix3 = cov(train3);
        [eigenvectors3, eigenvalues3] = svd(covmatrix3);
        pcavectrain3 = train3 * eigenvectors3(:, 1:2);
        pcavectest3 = test3 * eigenvectors3(:, 1:2);
        accup = [accup; Classify(k, pcavectrain1, pcavectest1, pcavectrain2, pcavectest2, pcavectrain3, pcavectest3)];


        %classifying data using LDA
        l1(1:length(train1)) = 1;
        train1 = [train1, transpose(l1)];
        l2(1:length(train2)) = 2;
        train2 = [train2, transpose(l2)];
        l3(1:length(train3)) = 3;
        train3 = [train3, transpose(l3)];

        dataset = [train1; train2; train3];

        [y, v, d] = tamu_lda(dataset(:,1:end-1), dataset(:, end));
        ldatrain1 = train1(:, 1:end-1) * v;
        ldatest1 = test1 * v;

        ldatrain2 = train2(:, 1:end-1) * v;
        ldatest2 = test2 * v;

        ldatrain3 = train3(:, 1:end-1) * v;
        ldatest3 = test3 * v;
        accul = [accul; Classify(k, ldatrain1, ldatest1, ldatrain2, ldatest2, ldatrain3, ldatest3)];
    end
    fprintf('Results for K = %d', k);
    disp(' ');
    fprintf('Mean accuracy for original space: %f', mean(accuk));
    disp(' ');
    fprintf('Mean accuracy for 2-D PCA space: %f', mean(accup));
    disp(' ');
    fprintf('Mean accuracy for 2-D LDA space: %f', mean(accul));
    disp(' ');
    disp(' ');
end
