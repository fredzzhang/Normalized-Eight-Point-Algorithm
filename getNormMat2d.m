function Nmatrix = getNormMat2d(x)
% Function: Compute the normalization matrix of 2d points in 
%           homogeneous coordinate
% Normalization criteria:
%   1. Move the centroidto the origin
%   2. Average distance of  points to the centroid is sqrt(2) 
% 
% Usage:
% 
%       Nmatrix = getNormMat(x)
%   where:
%       Nmatrix - the normalization matrix
%       x - input data, dim: 3xN
% 
% Institute: Australian National University
% Author: Zhen Zhang
% Last modified: 11 Apr. 2018

% Get the centroid
centroid = mean(x, 2);
% Compute the distance to the centroid
dist = sqrt(sum((x - repmat(centroid, 1, size(x, 2))) .^ 2, 1));
% Get the mean distance
mean_dist = mean(dist);
% Craft normalization matrix
Nmatrix = [sqrt(2) / mean_dist, 0, -sqrt(2) / mean_dist * centroid(1);...
           0, sqrt(2) / mean_dist, -sqrt(2) / mean_dist * centroid(2);...
           0, 0, 1];

end
