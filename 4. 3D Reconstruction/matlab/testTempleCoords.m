% A test script using templeCoords.mat
%
% Write your code here
%

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
corresp = load('../data/someCorresp.mat');

F = eightpoint(corresp.pts1, corresp.pts2, corresp.M);

coords = load('../data/templeCoords.mat');
coords.pts2 = epipolarCorrespondence(im1, im2, F, coords.pts1);

intrinsics = load('../data/intrinsics.mat');
E = essentialMatrix(F, intrinsics.K1, intrinsics.K2);

extrinsic1 = [eye(3), zeros(3, 1)];
P1 = intrinsics.K1 * extrinsic1;
extrinsic2s = camera2(E);
P2s = zeros(size(extrinsic2s));
for i = 1:4
    P2s(:, :, i) = intrinsics.K2 * extrinsic2s(:, :, i);
end

pts3ds = zeros([size(coords.pts1, 1), 3, 4]);
depth_count = zeros(4, 1);
for i = 1:4
    pts3ds(:, :, i) = triangulate(P1, coords.pts1, P2s(:, :, i), coords.pts2);
    depth_count(i) = sum(pts3ds(:, 3, i) > 0);
end
[~, correct] = max(depth_count);
P2 = P2s(:, :, correct);
pts3d = pts3ds(:, :, correct);

plot3(pts3d(:, 1), pts3d(:, 3), -pts3d(:, 2), '.'); axis equal

R1 = extrinsic1(:, 1:3);
t1 = extrinsic1(:, 4);
R2 = extrinsic2s(:, 1:3, correct_idx);
t2 = extrinsic2s(:, 4, correct_idx);

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
