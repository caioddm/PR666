function [feature] = extractAreas(imgnames)
    feature = zeros(length(imgnames),1);
    for idx = 1:length(imgnames)
        [img] = imresize(imread(imgnames(idx).name), [NaN 32]);
        binImg = imbinarize(rgb2gray(img));
        feature(idx,1) = getPartArea(binImg);

    end
end

function [totalArea] = getPartArea(img)
    x = size(img, 1);
    y = size(img, 2);
    totalArea = 0;
    for idx = 1:x
        for idy = 1:y            
            if(img(idx,idy) == 0)
                totalArea = totalArea + 1;
            end
        end
    end
    totalArea = totalArea/(x*y); %get part area compared to total image area
end