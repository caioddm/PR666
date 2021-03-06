function [ accuracy ] = ClassifyQuadratic( train1, test1, train2, test2, train3, test3 )
    rightclass = 0;
    totalclass = 0;
    totalLength = [train1; train2; train3];
    totalLength = length(totalLength(:,1));
    for i = 1 : length(test1(:,1))
        prior1 = length(train1(:,1))/totalLength;
        val1 = QuadraticClassifier(train1, test1(i,:), prior1);
        val2 = QuadraticClassifier(train2, test1(i,:), prior1);
        val3 = QuadraticClassifier(train3, test1(i,:), prior1);
        totalclass = totalclass + 1;
        if(val1 > val2 && val1 > val3)
            rightclass = rightclass + 1;
        end
    end

    for i = 1: length(test2(:,1))
        prior2 = length(train2(:,1))/totalLength;
        val1 = QuadraticClassifier(train1, test2(i,:), prior2);
        val2 = QuadraticClassifier(train2, test2(i,:), prior2);
        val3 = QuadraticClassifier(train3, test2(i,:), prior2);
        totalclass = totalclass + 1;
        if(val2 > val1 && val2 > val3)
            rightclass = rightclass + 1;
        end
    end

    for i = 1 : length(test3(:,1))
        prior3 = length(train3(:,1))/totalLength;
        val1 = QuadraticClassifier(train1, test3(i,:), prior3);
        val2 = QuadraticClassifier(train2, test3(i,:), prior3);
        val3 = QuadraticClassifier(train3, test3(i,:), prior3);
        totalclass = totalclass + 1;
        if(val3 > val1 && val3 > val2)
            rightclass = rightclass + 1;
        end
    end
    
    accuracy = rightclass/totalclass;

end

