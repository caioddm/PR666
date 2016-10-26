function [ accuracy ] = ClassifyQuadratic( train1, test1, train2, test2, train3, test3 )
    rightclass = 0;
    totalclass = 0;
    for i = 1 : length(test1)
        val1 = QuadraticClassifier(train1, test1(i,:));
        val2 = QuadraticClassifier(train2, test1(i,:));
        val3 = QuadraticClassifier(train3, test1(i,:));
        totalclass = totalclass + 1;
        if(val1 > val2 && val1 > val3)
            rightclass = rightclass + 1;
        end
    end

    for i = 1: length(test2)
        val1 = QuadraticClassifier(train1, test2(i,:));
        val2 = QuadraticClassifier(train2, test2(i,:));
        val3 = QuadraticClassifier(train3, test2(i,:));
        totalclass = totalclass + 1;
        if(val2 > val1 && val2 > val3)
            rightclass = rightclass + 1;
        end
    end

    for i = 1 : length(test3)
        val1 = QuadraticClassifier(train1, test3(i,:));
        val2 = QuadraticClassifier(train2, test3(i,:));
        val3 = QuadraticClassifier(train3, test3(i,:));
        totalclass = totalclass + 1;
        if(val3 > val1 && val3 > val2)
            rightclass = rightclass + 1;
        end
    end
    
    accuracy = rightclass/totalclass;

end

