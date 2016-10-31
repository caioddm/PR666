function [ label ] = KnnClassifier( data, k, x, numclasses )
    %dists = pdist2(x, data(:, 1:end-1)); %this line is not working on unix
    %matlab    
    x = repmat(x,length(data(:,1)),1);
    dists = sqrt(sum((data(:, 1:end-1)-x).^2, 2));
    
    data = [data, dists];
    [sorted_rows,sorted_inds] = sort(data(:,length(data(1,:))));
    sorted = data(sorted_inds,:);
    maxneig = 0;
    label = -1;
    for c = 1:numclasses
        neigs = sum(sorted(1:k, length(data(1,:))-1) == c);
        if(neigs > maxneig)
            maxneig = neigs;
            label = c;
        end
    end    
end

