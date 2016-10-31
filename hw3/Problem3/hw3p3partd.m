clear; clc;
addpath(genpath(pwd));
data = imread('hw3p3_im.jpg');

N = length(data(1,:,1))*length(data(:,1,1));
sse = zeros(10,1);
for k=1:10
    for it=1:10
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
        %distances = (double(data(:,:,1)) - double(img(:,:,1))).^2 + (double(data(:,:,2)) - double(img(:,:,2))).^2 + (double(data(:,:,3)) - double(img(:,:,3))).^2
        error = sum(sum(sum((double(data) - double(img)).^2)));
        if(error < sse(k, 1) || sse(k, 1) == 0)
            sse(k, 1) = error;
        end
    end
end

figure('Position', [200 100 1024 800]);
plot((1:10), sse(:, 1), 'LineWidth', 2);
ylabel('SSE');
xlabel('K');
title('Sum squared error for each value of K');



