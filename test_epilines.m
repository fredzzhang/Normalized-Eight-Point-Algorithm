% -------------------------------------------------------------------------
% Test the normalized 8-point algorithm on the KITTI sequence
% 
% Program Flow:
%   1. Read a pair of images and extract point correspondences
%   2. Compute fundamental matrix using normalized 8-point algorithm
%   3. Compute and draw epipolar lines on the paired images
% 
% Note: all extracted points will be used to compute fundamental matrix.
% Least squares will be used to solve the overdetermined linear system
% 
% Author: Frederic Zhang
% Last modified: 5 Jun. 2018
% -------------------------------------------------------------------------
close all;
clear;
clc;

% Intrinsic matrix of the camera with which the images were taken
K = [7.188560e+02 0.000000e+00 6.071928e+02; ...
 0.000000e+00 7.188560e+02 1.852157e+02; ...
 0.000000e+00 0.000000e+00 1.000000e+00];

% Read input images
I1 = imread('images/000080.png');
I2 = imread('images/000081.png');

% Find and extract SURF features
points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);
[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

% Match SURF features
indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

% Display matched features
k = 10;
figure;
showMatchedFeatures(I1, I2, ...
    matchedPoints1(1: k), matchedPoints2(1: k), 'montage');
title('Matched features between the image pair');

% Take the coordinates of matched features
p = matchedPoints1.Location;
q = matchedPoints2.Location;

% Compute fundamental matrix
E = eightPoint(p, q, K, K);
F = K' \ E / K;
F = F / F(3, 3);
disp('The fundamental matrix is:');
disp(F);

% Compute epipolar lines
epiLines1 = epipolarLine(F',q(1: k, :));
pLine1 = lineToBorderPoints(epiLines1, size(I1));
epiLines2 = epipolarLine(F, p(1: k, :));
pLine2 = lineToBorderPoints(epiLines2, size(I2));

% Draw the epipolar lines
figure;
imshow(I1);
line(pLine1(:, [1, 3])', pLine1(:, [2, 4])',...
    'LineWidth', 1.5, 'color', 'w');
hold on;
plot(p(1: k, 1), p(1: k, 2), 'ro', 'LineWidth', 2);
title('Epipolar lines of the 1st image (LEFT)');
figure;
imshow(I2);
line(pLine2(:, [1, 3])', pLine2(:, [2, 4])',...
    'LineWidth', 1.5, 'color', 'w');
hold on;
plot(q(1: k, 1), q(1: k, 2), 'co', 'LineWidth', 2);
title('Epipolar lines of the 2nd image (RIGHT)');