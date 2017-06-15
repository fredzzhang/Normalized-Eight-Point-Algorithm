function norm_mat = getNormalizationMatrix(p)
% -------------------------------------------------------------------------
% Function Introdution:
% Given a collection of 2D points under homogeneous coordinate, compute the
% normalization matrix to map the points to a unit-size coordinate system
% The centroid of the collection of points is set to be the origin through
% scaling and shifting. The square whose center is the centroid, side is
% twice the length of mean distance of the points to the centroid, will be
% mapped to a unit square ranging from -1 to 1

% Inputs:
% p - the coordinates of 2D points, wrapped in column vectors. The format
%   is [x; y; w]. The number of points is arbitrary as what's passed as
%   input. N points will result in a input matrix of size 3 x N

% Outputs:
% norm_mat - the corresponding normalization matrix for the collection of
%   points. It's of size 3 x 3

% Author: Frederic Zhang
% Last modified: 15 June 2017
% Version: 2.0
% -------------------------------------------------------------------------

% Compute the centroid of the points 
centroid = mean(p, 2);

% Compute the distance between the points and the centroid
dists = sqrt(sum((p - repmat(centroid, 1, size(p, 2))) .^ 2));
mean_dist = mean(dists);

% Craft normalization matrix
norm_mat = [sqrt(2) / mean_dist, 0, - sqrt(2) / mean_dist * centroid(1); ...
            0, sqrt(2) / mean_dist, - sqrt(2) / mean_dist * centroid(2); ...
            0, 0, 1];
        
end