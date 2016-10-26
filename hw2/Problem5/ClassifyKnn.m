function [ accuracy ] = ClassifyKnn( k, train1, test1, train2, test2, train3, test3 )
    rightclass = 0;
    totalclass = 0;
    l1(1:length(train1), 1) = 1;
    l2(1:length(train2), 1) = 2;
    l3(1:length(train3), 1) = 3;
    train1 = [train1, l1];
    train2 = [train2, l2];
    train3 = [train3, l3];
    train_data = [train1; train2; train3];
    
    for i = 1 : length(test1)
        lbl = KnnClassifier(train_data, k, test1(i,:));
        totalclass = totalclass + 1;
        if(lbl == 1)
            rightclass = rightclass + 1;
        end
    end

    for i = 1: length(test2)
        lbl = KnnClassifier(train_data, k, test2(i,:));
        totalclass = totalclass + 1;
        if(lbl == 2)
            rightclass = rightclass + 1;
        end
    end

    for i = 1 : length(test3)
        lbl = KnnClassifier(train_data, k, test3(i,:));
        totalclass = totalclass + 1;
        if(lbl == 3)
            rightclass = rightclass + 1;
        end
    end
    
    accuracy = rightclass/totalclass;
end

