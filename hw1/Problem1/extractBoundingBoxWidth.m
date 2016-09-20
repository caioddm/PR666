function [feature] = extractBoundingBoxWidth(imgnames)
    feature = zeros(length(imgnames),1);
    for idx = 1:length(imgnames)
        [img] = imresize(imread(imgnames(idx).name), [NaN 32]);
        binImg = imbinarize(rgb2gray(img));
        feature(idx,1) = getPartWidth(binImg);

    end
end

function [longestWidth] = getPartWidth(img)
    x = size(img, 1);
    y = size(img, 2);
    longestWidth = -1;
    for idx = 1:x
        startX = -1;
        endX = -1;
        for idy = 1:y            
            if(img(idx,idy) == 0)
                if(startX == -1)
                    startX = idy;                
                else
                    endX = idy;
                end
            end
        end        
        if(endX - startX > longestWidth)
            longestWidth = endX - startX;
        end
    end
    longestWidth = longestWidth/y; %get longest width size relative to total image width
end