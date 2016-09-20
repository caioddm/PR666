function [feature] = extractPixelIntensityAverage(imgnames)
    feature = zeros(length(imgnames),1);
    for idx = 1:length(imgnames)
        [img] = imread(imgnames(idx).name);
        grayImg = rgb2gray(img);
        feature(idx,1) = getPixelAverage(grayImg);

    end
end

function [average] = getPixelAverage(grayImg)
    x = size(grayImg, 1);
    average = [];
    for idx = 1:x
        average = [average, grayImg(idx,:,1)];
    end
    average = mean(average);
end

