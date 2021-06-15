% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
cv_cover = imread('../data/cv_cover.jpg');
if ndims(cv_cover) == 3
    cv_cover = rgb2gray(cv_cover);
end
%% Compute the features and descriptors
f1 = detectFASTFeatures(cv_cover);
%f1 = detectSURFFeatures(cover);
[d1, l1] = computeBrief(cv_cover, f1.Location);
for i = 0:36
    %% Rotate image
    rot = imrotate(cv_cover, i*10);
    %% Compute features and descriptors
    f2 = detectFASTFeatures(rot);
    %f2 = detectSURFFeatures(rot);
    [d2, l2] = computeBrief(cv_cover, f2.Location);
    %% Match features
    indPairs = matchFeatures(d1, d2, 'MatchThreshold', 10.0, 'MaxRatio', 1.0);
    locs1 = l1(indPairs(:,1),:);
    locs2 = l2(indPairs(:,2),:);
    
    %% Visualise Matched Features
    %showMatchedFeatures(cv_cover, rot, locs1, locs2, 'montage')
    %% Update histogram
    hist(i+1) = size(indPairs, 1);
end

%% Display histogram

x = (10:10:370);

figure
bar(x, hist)
xlabel('Rotation in Degrees') 
ylabel('Number of Matches') 
title('FAST')

% figure
% bar(x, hist)
% xlabel('Rotation in Degrees') 
% ylabel('Number of Matches') 
% title('SURF')