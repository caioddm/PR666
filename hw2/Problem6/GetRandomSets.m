function [ train, test ] = GetRandomSets( data, ratio )
numvideos = floor(length(data(:,1))*ratio);
randomidxs = randperm(length(data(:,1)));

train = zeros(length(data(:,1)) - numvideos, length(data(1, :)));
test = zeros(numvideos, length(data(1, :)));
testidx = 1;
trainidx = 1;
for i = 1 : length(data(:,1))
    if(i <= numvideos)
        test(testidx, :) = data(randomidxs(i), :);
        testidx = testidx + 1;
    else
        train(trainidx, :) = data(randomidxs(i), :);
        trainidx = trainidx + 1;
    end
end

end

