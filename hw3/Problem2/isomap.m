function [ embedding ] = isomap( distances, dims )

distmatrix = distances;

%construct embedding
N = length(distances(:,1));
H = eye(N) - ones(N,1)*ones(1,N)/N;
taudists = -1*H*(distmatrix.^2)*H/2;
[eigenvectors, eigenvalues] = eigs(taudists, dims, 'LR');
eigenvalues = diag(eigenvalues);
embedding = zeros(N, dims);
for idx=1:length(embedding(:,1))
    for jdx=1:length(embedding(1,:))
        embedding(idx, jdx) = sqrt(eigenvalues(jdx))*eigenvectors(idx, jdx);
    end
end

end

