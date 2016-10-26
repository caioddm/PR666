function [ val ] = QuadraticClassifier( data, x, prior )

x = transpose(x);
mu = transpose(mean(data));
cov_matrix = cov(data);

val = ((-1/2)*transpose(x-mu)*pinv(cov_matrix)*(x-mu)) - (1/2*log(det(cov_matrix)) + log(prior));
end

