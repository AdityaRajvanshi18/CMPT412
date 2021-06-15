function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

N = size(pts1, 1);
T = [1/M, 0, 0; 0, 1/M, 0; 0, 0, 1];
pts1s = (T * [pts1, ones(N, 1)]')';
pts2s = (T * [pts2, ones(N, 1)]')';

u = pts1s(:, 1);
v = pts1s(:, 2);
x = pts2s(:, 1);
y = pts2s(:, 2);
A = [u.*x, u.*y, u, v.*x, v.*y, v, x, y, ones(N,1)];

[~, ~, V] = svd(A);
F = reshape(V(:, end), 3, 3);

[U, S, V] = svd(F);
S(end, end) = 0;
F2 = U*S*V;

F_ref = refineF(F2, pts1s, pts2s);

F = T' * F_ref * T;


end

