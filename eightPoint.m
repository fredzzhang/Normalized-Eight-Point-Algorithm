function[eMatrix] = eightPoint(matchedPoints1, matchedPoints2, K1, K2)
% -------------------------------------------------------------------------
% Function Introdution:
% Given a set of correspondences between two images and the intrisic matrix
% of the calibrated camera for both views, compute the essential matrix
% associated with the epipolar geometry using eight points

% Inputs:
% matchedPoints1 - the coordinates of matched features in the first image,
%   expressed in inhomogeneous coordinate. The size is of Nx2, where N is the
%   number of matched points
% matchedPoints2 - same as above
% K1 - the intrisic matrix of the calibrated camera from the first view
% K2 - the intrisic matrix of the calibrated camera from the second view

% Outputs:
% eMatrix - the computed essential matrix

% Author: Frederic Zhang
% Last modified: 5 Jun. 2018
% Version: 3.0
% -------------------------------------------------------------------------

% 8-point algorithm

% Error checking
[n1, c1] = size(matchedPoints1);
[n2, c2] = size(matchedPoints2);
if((c1 ~= 2) || (c2 ~= 2))
    error('Points are not formated with correct number of coordinates.');
end
if((n1 < 8) || (n2 < 8))
    error('There are not enough points to carry out the operation.');
end

% Arrange data
p1 = transpose([matchedPoints1(1: 8, :), ones(8, 1)]);
p2 = transpose([matchedPoints2(1: 8, :), ones(8, 1)]);
norm1 = getNormMat2d(p1);
norm2 = getNormMat2d(p2);

% Normalisation
p1 = norm1 * p1;
p2 = norm2 * p2;

p1 = transpose(p1 ./ repmat(p1(3, :), [3, 1]));
p2 = transpose(p2 ./ repmat(p2(3, :), [3, 1]));

x1 = p1(:, 1);
y1 = p1(:, 2);
x2 = p2(:, 1);
y2 = p2(:, 2);

% Craft matrix A
A = [x2 .* x1, x2 .* y1, x2, y2 .* x1, y2 .* y1, y2, x1, y1, ones(8, 1)];
% Perform SVD
[~, ~, V] = svd(A);
fMatrix = [V(1, 9), V(2, 9), V(3, 9); V(4, 9), V(5, 9), V(6, 9); V(7, 9), V(8, 9), V(9, 9)];
% Obtain fundamental matrix
[U, S, V] = svd(fMatrix);
fMatrix = U(:, 1) * S(1,1) * transpose(V(:, 1)) + U(:, 2) * S(2,2) * transpose(V(:, 2));
fMatrix = norm2' * fMatrix * norm1;

% Return essential matrix
eMatrix = K2' * fMatrix * K1;

end