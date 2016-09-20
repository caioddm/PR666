function [feature] = extractBoundingBoxHeight(imgnames)
    feature = zeros(length(imgnames),1);
    for idx = 1:length(imgnames)
        [img] = imresize(imread(imgnames(idx).name), [NaN 32]);
        binImg = imbinarize(rgb2gray(img));
        feature(idx,1) = getPartHeight(binImg);

    end
end

function [longestHeight] = getPartHeight(img)
    x = size(img, 1);
    y = size(img, 2);
    longestHeight = -1;
    for idy = 1:y
        startY = -1;
        endY = -1;
        for idx = 1:x            
            if(img(idx,idy) == 0)
                if(startY == -1)
                    startY = idx;                
                else
                    endY = idx;
                end
            end
        end        
        if(endY - startY > longestHeight)
            longestHeight = endY - startY;
        end
    end
    longestHeight = longestHeight/x; %get longest height size relative to total image height
end