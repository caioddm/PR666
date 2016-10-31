clear; clc;
addpath(genpath(pwd));
data = imread('hw3p3_im.jpg');

N = length(data(1,:,1))*length(data(:,1,1));
figure('Position', [100 100 1024 800]);
for k=1:10
    img = reshape(data, N, 3);
    clusters = zeros(N, 1);
    indices = randperm(N);
    el_per_clus = floor(N/k);
    for idx=1:k
        if(k == idx)
            clusters(indices((idx-1)*el_per_clus + 1:end), 1) = idx;
        else
            clusters(indices((idx-1)*el_per_clus + 1:idx*el_per_clus), 1) = idx;
        end
    end
    img = [img clusters];
    outimg = zeros(N,3, 'uint8');
    changed = true;
    while changed
        changed = false;
        centers = zeros(k,3);
        for idx=1:k
            points = img(img(:,end) == idx, 1:3);
            centers(idx, :) = mean(points);
        end
        distances = pdist2(img(:, 1:3), centers);
        for idx=1:length(img(:,1))
            [val, ind] = min(distances(idx,:));
            if(ind ~= img(idx, end))
                changed = true;
            end
            img(idx, end) = ind;
            outimg(idx, :) = uint8(centers(ind, :));
        end
    end
    img = outimg;
    img = reshape(img, length(data(:,1,1)), length(data(1,:,1)), 3);
    subplot(2, 5, k);
    imagesc(img, [0 255]);
    title(sprintf('k=%d', k));
    imwrite(img, sprintf('c%d.jpg', k));
end



