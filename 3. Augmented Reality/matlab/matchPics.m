function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!
threshold = 10.0;
brief_threshold = 1.0;
%% Convert images to grayscale, if necessary
if ndims(I1) == 3
    I1 = rgb2gray(I1);
end
if ndims(I2) == 3
    I2 = rgb2gray(I2);
end
%% Detect features in both images
f1 = detectFASTFeatures(I1);
f2 = detectFASTFeatures(I2);
%f1 = detectSURFFeatures(I1);
%f2 = detectSURFFeatures(I2);
%% Obtain descriptors for the computed feature locations
[d1, l1] = computeBrief(I1, f1.Location);
[d2, l2] = computeBrief(I2, f2.Location);
%% Match features using the descriptors
indPairs = matchFeatures(d1, d2, 'MatchThreshold', threshold, 'MaxRatio', brief_threshold);

locs1 = l1(indPairs(:,1),:);
locs2 = l2(indPairs(:,2),:);

showMatchedFeatures(I1, I2, locs1, locs2, 'montage')
end

