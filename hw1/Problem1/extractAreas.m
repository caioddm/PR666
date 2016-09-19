function [feature] = extractAreas(imgnames)
    feature = zeros(length(imgnames),1);
    for idx = 1:length(imgnames)
        [img] = imresize(imread(imgnames(idx).name), [NaN 32]);
        grayImg = imbinarize(rgb2gray(img));
        feature(idx,1) = getPartArea(grayImg);

    end
end

function [totalArea] = getPartArea(grayImg)
    threshold = 90;
    x = size(grayImg, 1);
    y = size(grayImg, 2);
    bgAverage = mean([grayImg(1:3,1);grayImg(1:3,2);grayImg(1:3,3)]); %computes average value for background considering a top left 3x3 matrix    
    totalArea = 0;
    for idx = 1:x
        for idy = 1:y            
            if(grayImg(idx,idy) == 0)
                totalArea = totalArea + 1;
            end
        end
    end
    totalArea = totalArea/(x*y); %get part area compared to total image area
end