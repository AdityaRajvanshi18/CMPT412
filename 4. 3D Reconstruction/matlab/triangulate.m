function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
N = size(pts1, 1);
p11 = P1(1, :);
p12 = P1(2, :);
p13 = P1(3, :);
p21 = P2(1, :);
p22 = P2(2, :);
p23 = P2(3, :);
pts3d = zeros(N, 3);

for i = 1:N
    x1 = pts1(i, 1);
    y1 = pts1(i, 2);
    x2 = pts2(i, 1);
    y2 = pts2(i, 2);
    A = [x1 .* p13 - p11;
         y1 .* p13 - p12;
         x2 .* p23 - p21;
         y2 .* p23 - p22];
    [~, ~, V] = svd(A);
    v = V(:,end);
    pts3d(i, :) = v(1:3) ./ v(4);
end