function [ accuracy ] = ClassifyKnn( k, train, test, numclasses )
    rightclass = 0;
    totalclass = 0;
    
    for i = 1 : length(test(:,1))
        lbl = KnnClassifier(train, k, test(i,1:end-1), numclasses);
        totalclass = totalclass + 1;
        if(lbl == test(i,end))
            rightclass = rightclass + 1;
        end
    end
    
    accuracy = rightclass/totalclass;
end

