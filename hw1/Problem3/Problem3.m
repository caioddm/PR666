clear; clc;
addpath(genpath(pwd));

%Maximum likelihood solution
syms x;
res = solve(18*log(1/3) + 800*x^2 - 1800*x + 900 == 0);
x_1 = double(res(1));
x_2 = double(res(2));
disp('Maximum Likelihood x1 and x2');
disp(x_1);
disp(x_2)

%Maximum a posteriori solution
syms x;
res = solve(18*log(3333) + 800*x^2 - 1800*x + 900 == 0);
x_1 = double(res(1));
x_2 = double(res(2));
disp('Maximum a posteriori x1 and x2:');
disp(x_1);
disp(x_2);

%Minimum Bayes Risk
syms x;
res = solve(18*log(66.66) + 800*x^2 - 1800*x + 900 == 0);
x_1 = double(res(1));
x_2 = double(res(2));
disp('Minimum bayes risk x1 and x2:');
disp(x_1);
disp(x_2);
