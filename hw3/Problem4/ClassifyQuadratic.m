function [ accuracy ] = ClassifyQuadratic( train, test, numclasses)
    rightclass = 0;
    totalclass = 0;
    totalLength = length(train(:,1));
    maxval = -Inf;
    class = -1;
    for i = 1 : length(test(:,1))        
        for c = 1:numclasses
            trainclass = train(train(:, end) == c, 1:end-1);
            prior = length(trainclass(:,1))/totalLength;
            val = QuadraticClassifier(trainclass, test(i,1:end-1), prior);            
            if(val > maxval)
                maxval = val;
                class = c;
            end
        end
        totalclass = totalclass + 1;
        if(class == test(i,end))
            rightclass = rightclass + 1;
        end
    end
    accuracy = rightclass/totalclass;
end

