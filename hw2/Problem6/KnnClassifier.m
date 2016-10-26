function [ label ] = KnnClassifier( data, k, x )
    dists = pdist2(x, data(:,1:end-1));
    data = [data, transpose(dists)];
    [~,sorted_inds] = sort(data(:,length(data(1,:))));
    sorted = data(sorted_inds,:); 
    l1 = sum(sorted(1:k, length(data(1,:))-1) == 1);
    l2 = sum(sorted(1:k, length(data(1,:))-1) == 2);
    l3 = sum(sorted(1:k, length(data(1,:))-1) == 3);
    if(l1 >= l2 && l1 >= l3)
        label = 1;
    elseif(l2 >= l1 && l2 >= l3)
        label = 2;
    else
        label = 3;
    end
end

