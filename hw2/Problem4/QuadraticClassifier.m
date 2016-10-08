function [ val ] = QuadraticClassifier( data, x )

x = transpose(x);
mu = transpose(mean(data));
cov_matrix = cov(data);

val = ((-1/2)*transpose(x-mu)*inv(cov_matrix)*(x-mu)) - (1/2*log(det(cov_matrix)) + log(1/3));
end

