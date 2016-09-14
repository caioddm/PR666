function [vector] = vectorizedFeatures(feat)    
    vector = [feat(:,1); feat(:,2); feat(:,3); feat(:,4)];
end