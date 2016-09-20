function [ MSE ] = ComputePolynomial(data, order, training_size, shouldPlot)
idxs = (1:length(data.x));
num_points = length(idxs);
randomidxs = randperm(num_points);

train = zeros(training_size, 2);
for i = 1 : training_size
    train(i, 1) = data.x(randomidxs(i));
    train(i, 2) = data.y(randomidxs(i));
end

p = polyfit(train(:,1),train(:,2),order);
x = (-0.25:0.001:1.1);
y = polyval(p,x);
test = zeros(num_points - training_size, 2);
%test values model output vs real values
for i = training_size+1 : num_points 
    test(i - training_size, 1) = data.x(randomidxs(i));
    test(i - training_size, 2) = data.y(randomidxs(i));
end

if shouldPlot
    figure('Name', sprintf('Test samples model output vs. real values, polynomial order %d', order), 'Position', [100 200 800 800]);
    plot(test(:, 1),test(:, 2), 'x');
    hold on
    plot(x,y)
    hold off
end
%computing MSE
MSE = mean((test(:,2) - polyval(p, test(:,1))).^2);


end

