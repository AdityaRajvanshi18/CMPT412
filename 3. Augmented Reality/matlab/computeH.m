function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
n = size(x1, 1);
p1 = x1;
p2 = x2;

X1 = p1(:,1);
X2 = p2(:,1);
Y1 = p1(:,2);
Y2 = p2(:,2);

A = [
    -X2 -Y2 -ones(n, 1) zeros(n, 3) X2.*X1 Y2.*X1 X1;
    zeros(n, 3) -X2 -Y2 -ones(n, 1) X2.*Y1 Y2.*Y1 Y1
    ];

[~, ~, V] = svd(A);

H2to1 = reshape(V(:, end), 3, 3).';
H2to1 = H2to1/H2to1(end);

end

