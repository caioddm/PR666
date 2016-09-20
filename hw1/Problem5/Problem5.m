clear; clc;
addpath(genpath(pwd));
data = load('hw1p5_data.mat');

%(1) randomly selecting 10 data points to generate the polynomial model of
%order 1 and comparing the model with the test set
MSE = ComputePolynomial(data, 1, 10, true);
disp('MSE for polynomial order 1:');
disp(MSE);

%(2) Repeating part 1 for polynomials of order 2 to 10
for order = 2:10
    MSE = ComputePolynomial(data, order, 10, true);
    disp(sprintf('MSE for polynomial order %d:', order));
    disp(MSE);
end

%(3) Repeating parts 1 and 2 100 times and computing average MSE
MSEs = zeros (10, 100);
log_MSEs = zeros(9,1);
for order = 2:10
    for it = 1:100
        MSE = ComputePolynomial(data, order, 10, false);
        MSEs(order,it) = MSE;
    end
    disp(sprintf('Average MSE on 100 iterations for polynomial order %d:', order));
    disp(mean(MSEs(order)));
    log_MSEs(order-1) = log(mean(MSEs(order)));
end

figure('Name', 'Average log-MSE vs. polynomial order', 'Position', [900 200 800 800]);
plot((2:10),log_MSEs(:,1), 'x');

%(4) Repeat parts 1-3 with different training sets sizes
sets_sizes = [15 20 25 50 100 200];
for idx = 1:length(sets_sizes)
    MSEs = zeros (10, 100);
    log_MSEs = zeros(9,1);
    for order = 2:10
        for it = 1:100
            MSE = ComputePolynomial(data, order, sets_sizes(idx), false);
            MSEs(order,it) = MSE;
        end
        disp(sprintf('Average MSE on 100 iterations for polynomial order %d with set size of %d:', order, sets_sizes(idx)));
        disp(mean(MSEs(order)));
        log_MSEs(order-1) = log(mean(MSEs(order)));
    end

    figure('Name', sprintf('Average log-MSE vs. polynomial order with set size of %d', sets_sizes(idx)), 'Position', [900 200 800 800]);
    plot((2:10),log_MSEs(:,1), 'x');
end