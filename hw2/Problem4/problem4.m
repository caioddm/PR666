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


%compute quadratic classifier
accuq = [];
accup = [];
accul = [];
for k = 1 : 30
    [train1, test1] = GetRandomSets(set1, 1/4);
    [train2, test2] = GetRandomSets(set2, 1/4);
    [train3, test3] = GetRandomSets(set3, 1/4);
    accuq = [accuq; ClassifyQuadratic(train1, test1, train2, test2, train3, test3)];
    
    %computing PCA with training data
    
    if(k == 1) %plot 3D PCA projections on the first iteration
        covmatrix = cov([train1; train2; train3]);
        [eigenvectors, eigenvalues] = svd(covmatrix);
        pcavectrain1 = train1 * eigenvectors(:, 1:3);
        pcavectest1 = test1 * eigenvectors(:, 1:3);

        pcavectrain2 = train2 * eigenvectors(:, 1:3);
        pcavectest2 = test2 * eigenvectors(:, 1:3);

        pcavectrain3 = train3 * eigenvectors(:, 1:3);
        pcavectest3 = test3 * eigenvectors(:, 1:3);
        figure('Position', [100 100 1024 800]);
        hold on
        subplot(2,1,1);
        pcavectrain = [pcavectrain1; pcavectrain2; pcavectrain3];
        scatter3(pcavectrain(:,1), pcavectrain(:,2), pcavectrain(:,3), 0.001);    
        
        text(pcavectrain1(:,1), pcavectrain1(:,2), pcavectrain1(:,3), '1', 'color', 'b');        
        text(pcavectrain2(:,1), pcavectrain2(:,2), pcavectrain2(:,3), '2', 'color', 'r');
        text(pcavectrain3(:,1), pcavectrain3(:,2), pcavectrain3(:,3), '3', 'color', 'g');        
        title('PCA scatter using training data projections');
        hold off;
        
        hold on
        subplot(2,1,2);     
        pcavectest = [pcavectest1; pcavectest2; pcavectest3];
        scatter3(pcavectest(:,1), pcavectest(:,2), pcavectest(:,3), 0.001);
        
        text(pcavectest1(:,1), pcavectest1(:,2), pcavectest1(:,3), '1', 'color', 'b');        
        text(pcavectest2(:,1), pcavectest2(:,2), pcavectest2(:,3), '2', 'color', 'r');
        text(pcavectest3(:,1), pcavectest3(:,2), pcavectest3(:,3), '3', 'color', 'g');
        title('PCA scatter using test data projections');
        hold off;
    end    
    
    %classifying data in a 2D PCA
    covmatrix = cov([train1; train2; train3]);
    [eigenvectors, eigenvalues] = svd(covmatrix);
    pcavectrain1 = train1 * eigenvectors(:, 1:2);
    pcavectest1 = test1 * eigenvectors(:, 1:2);

    pcavectrain2 = train2 * eigenvectors(:, 1:2);
    pcavectest2 = test2 * eigenvectors(:, 1:2);

    pcavectrain3 = train3 * eigenvectors(:, 1:2);
    pcavectest3 = test3 * eigenvectors(:, 1:2);
    accup = [accup; ClassifyQuadratic(pcavectrain1, pcavectest1, pcavectrain2, pcavectest2, pcavectrain3, pcavectest3)];
    
    
    %classifying data using LDA
    l1(1:length(train1)) = 1;
    train1 = [train1, transpose(l1)];
    l2(1:length(train2)) = 2;
    train2 = [train2, transpose(l2)];
    l3(1:length(train3)) = 3;
    train3 = [train3, transpose(l3)];
    if(k == 1) %plot 2D LDA projections on the first iteration
        
        dataset = [train1; train2; train3];

        [y, v, d] = tamu_lda(dataset(:,1:end-1), dataset(:, end));
        ldatrain1 = train1(:, 1:end-1) * v;
        ldatest1 = test1 * v;
        
        ldatrain2 = train2(:, 1:end-1) * v;
        ldatest2 = test2 * v;
        
        ldatrain3 = train3(:, 1:end-1) * v;
        ldatest3 = test3 * v;

        figure('Position', [200 100 1024 800]);
        hold on
        subplot(2,1,1);
        ldatrain = [ldatrain1; ldatrain2; ldatrain3];        
        scatter(ldatrain(:,1), ldatrain(:,2), 0.001);
        text(ldatrain1(:,1), ldatrain1(:,2), '1', 'color', 'b');
        text(ldatrain2(:,1), ldatrain2(:,2), '2', 'color', 'r');
        text(ldatrain3(:,1), ldatrain3(:,2), '3', 'color', 'g');   
                  
        title('LDA scatter using training data projections');
        hold off;
        
        hold on
        subplot(2,1,2);        
        ldatest = [ldatest1;ldatest2;ldatest3];
        scatter(ldatest(:,1), ldatest(:,2), 0.001); 
        text(ldatest1(:,1), ldatest1(:,2), '1', 'color', 'b');
        text(ldatest2(:,1), ldatest2(:,2), '2', 'color', 'r');
        text(ldatest3(:,1), ldatest3(:,2), '3', 'color', 'g');
               
        title('LDA scatter using test data projections');
        hold off;
    end
    
    dataset = [train1; train2; train3];

    [y, v, d] = tamu_lda(dataset(:,1:end-1), dataset(:, end));
    ldatrain1 = train1(:, 1:end-1) * v;
    ldatest1 = test1 * v;

    ldatrain2 = train2(:, 1:end-1) * v;
    ldatest2 = test2 * v;

    ldatrain3 = train3(:, 1:end-1) * v;
    ldatest3 = test3 * v;
    accul = [accul; ClassifyQuadratic(ldatrain1, ldatest1, ldatrain2, ldatest2, ldatrain3, ldatest3)];
end

fprintf('Mean accuracy for original space: %f', mean(accuq));
disp(' ');
fprintf('Mean accuracy for 2-D PCA space: %f', mean(accup));
disp(' ');
fprintf('Mean accuracy for 2-D LDA space: %f', mean(accul));
disp(' ');








