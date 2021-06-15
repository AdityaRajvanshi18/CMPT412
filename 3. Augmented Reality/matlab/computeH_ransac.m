function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
T = 5000;
[l, ~] = size(locs1);
d = 20;
inliersCount = 0;

minE = inf;
for t = 1:T
    
    ranPoint = randperm(l, 4);
    Ht = computeH_norm(locs1(ranPoint,:), locs2(ranPoint,:));
        
    locs1_ = (Ht * [locs2 ones([l, 1])]')'; 
    dv = locs1_(:,1:2) ./ locs1_(:,3) - locs1;
    ds = abs(sqrt(dv(:,1).^2 + dv(:,2).^2));
    
    i = ds < d;
    i(ranPoint) = false;
    iC = sum(i);
    sse = sum(ds(i) .^ 2);
    if iC > inliersCount || iC == inliersCount && sse < minE
        minE = sse;
        inliers = i;
        inliersCount = iC;
    end
end
bestH2to1 = computeH_norm(locs1(inliers,:), locs2(inliers,:));
end

