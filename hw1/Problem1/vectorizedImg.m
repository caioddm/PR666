function [vector] = vectorizedImg(img)    
    x = size(img, 1);
    y = size(img, 2);
    vector = zeros(1, (x*y));
    grayImg = rgb2gray(img);
    counter = 0;
    for idx = 1:x
        for idy = 1:y
            vector(1, (floor(counter/x))*x + idy) = grayImg(idx, idy, 1);
            counter = counter + 1;
        end
    end    
end