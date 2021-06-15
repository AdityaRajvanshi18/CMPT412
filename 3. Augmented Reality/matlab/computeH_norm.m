function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
t1 = x1 - centroid1;
t2 = x2 - centroid2;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
dist_t1 = sqrt(sum(t1.^2, 2));
dist_t2 = sqrt(sum(t2.^2, 2));
s1 = sqrt(2)/mean(dist_t1);
s2 = sqrt(2)/mean(dist_t2);

x1norm = s1 * t1;
x2norm = s2 * t2;
%% similarity transform 1
tx = -s1*centroid1(1);
ty = -s1*centroid1(2);
T1 = [s1 0 tx; 0 s1 ty; 0 0 1];

%% similarity transform 2
tx = -s2*centroid2(1);
ty = -s2*centroid2(2);
T2 = [s2 0 tx; 0 s2 ty; 0 0 1];

%% Compute Homography
Hnorm = computeH(x1norm, x2norm);
%% Denormalization
H2to1 = inv(T1)*Hnorm*T2;
end