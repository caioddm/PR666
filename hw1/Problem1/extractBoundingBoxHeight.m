function [feature] = extractBoundingBoxHeight(imgnames)
    feature = zeros(length(imgnames),1);
    for idx = 1:length(imgnames)
        [img] = imresize(imread(imgnames(idx).name), [NaN 32]);
        grayImg = imbinarize(rgb2gray(img));
        feature(idx,1) = getPartHeight(grayImg);

    end
end

function [longestHeight] = getPartHeight(grayImg)
    threshold = 90;
    x = size(grayImg, 1);
    y = size(grayImg, 2);
    bgAverage = mean([grayImg(1:3,1);grayImg(1:3,2);grayImg(1:3,3)]); %computes average value for background considering a top left 3x3 matrix    
    longestHeight = -1;
    for idy = 1:y
        startY = -1;
        endY = -1;
        for idx = 1:x            
            difference = 0;
            if(grayImg(idx,idy,1) > bgAverage) 
                difference = abs(grayImg(idx,idy,1) - bgAverage);
            else
                difference = abs(bgAverage - grayImg(idx,idy,1));
            end
            if(grayImg(idx,idy,1) == 0)
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