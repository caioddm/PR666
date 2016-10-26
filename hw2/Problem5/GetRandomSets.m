function [ train, test ] = GetRandomSets( data, ratio )
numvideos = floor(length(data)*ratio);
randomidxs = randperm(length(data));

train = zeros(length(data) - numvideos, 51);
test = zeros(numvideos, 51);
testidx = 1;
trainidx = 1;
for i = 1 : length(data)
    if(i <= numvideos)
        test(testidx, :) = data(randomidxs(i), :);
        testidx = testidx + 1;
    else
        train(trainidx, :) = data(randomidxs(i), :);
        trainidx = trainidx + 1;
    end
end

end

