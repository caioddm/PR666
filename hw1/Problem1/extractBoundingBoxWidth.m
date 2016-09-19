function [feature] = extractBoundingBoxWidth(imgnames)
    feature = zeros(length(imgnames),1);
    for idx = 1:length(imgnames)
        [img] = imresize(imread(imgnames(idx).name), [NaN 32]);
        grayImg = imbinarize(rgb2gray(img));
        feature(idx,1) = getPartWidth(grayImg);

    end
end

function [longestWidth] = getPartWidth(grayImg)
    threshold = 90;
    x = size(grayImg, 1);
    y = size(grayImg, 2);
    bgAverage = mean([grayImg(1:3,1);grayImg(1:3,2);grayImg(1:3,3)]); %computes average value for background considering a top left 3x3 matrix    
    longestWidth = -1;
    for idx = 1:x
        startX = -1;
        endX = -1;
        for idy = 1:y            
            difference = 0;
            if(grayImg(idx,idy,1) > bgAverage) 
                difference = abs(grayImg(idx,idy,1) - bgAverage);
            else
                difference = abs(bgAverage - grayImg(idx,idy,1));
            end
            if(grayImg(idx,idy,1) == 0)
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