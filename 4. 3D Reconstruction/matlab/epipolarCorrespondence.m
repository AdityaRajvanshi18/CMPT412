function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
im1 = im2double(rgb2gray(im1));
im2 = im2double(rgb2gray(im2));

N = size(pts1, 1);
height = size(im1, 1);
width = size(im1, 2);

window = 10;
h = floor(window/2);
pts2 = zeros(size(pts1));
for i = 1:N
    x1 = pts1(i, 1);
    y1 = pts1(i, 2);
    im1_wind = im1(y1-h:y1+h, x1-h:x1+h);

    line = F * [x1 y1 1]';
    xs2 = (1+h):(width-h);
    ys2 = round(-(line(1) .* xs2 + line(3)) ./ line(2));
    C = size(xs2, 2);

    best = {};
    best.idx = 1;
    best.dist = width;
    
    for c = 1:C
        minX = max(1, xs2(c)-h);
        maxX = min(width, xs2(c)+h);
        minY = max(1, ys2(c)-h);
        maxY = min(height, ys2(c)+h);

        diff = (im1_wind - im2(minY:maxY, minX:maxX));
        dist = norm(single(diff), 1);
        
        if dist < best.dist
            best.dist = dist;
            best.idx = c;
        end
    end
    pts2(i, :) = [xs2(best.idx) ys2(best.idx)];
end
