clear; clc;
addpath(genpath(pwd));
%(a) generate a single pdf
% West indian avocado N(1500, 300)
% Guatemalan N(500, 100)
% Mexican N(200, 100)

x = [-100:.1:3000];
x = transpose(x);
mu = zeros(3, 1);
sigma = zeros(1,1,3);
p = zeros(1,3);

%west indian
mu(1,1) = 1500;
sigma(1,1,1) = 300^2;
p(1,1) = 0.35;

%guatemalan
mu(2,1) = 500;
sigma(1,1,2) = 100^2;
p(1,2) = 0.4;

%mexican
mu(3,1) = 200;
sigma(1,1,3) = 100^2;
p(1,3) = 0.25;


gmm = gmdistribution(mu,sigma,p);
figure('Name', 'Pdf model for avocados weights and histograms', 'Position', [100 200 1600 800]);
subplot(2,2,1);
plot(x, pdf(gmm, x));
title('Pdf model for avocados weights');

%(b) generate 200 random samples according to the distribution
subplot(2,2,2);
samples = random(gmm, 200);
histogram(samples, 50, 'Normalization','pdf');
title('Histogram for 200 samples');

%(c) generate 20000 random samples according to the distribution
subplot(2,2,3);
samples = random(gmm, 20000);
histogram(samples, 50, 'Normalization','pdf');
title('Histogram for 20000 samples');
