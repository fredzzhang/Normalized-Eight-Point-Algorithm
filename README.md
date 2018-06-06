# 8-point-algorithm-MATLAB

## Code Structure

### eightPoint.m
Normalized 8-point algorithm implemented in MATLAB

	Usage: E = eightPoint(p, q, K1, K2)
		where:
			E - essential matrix between the image pair
			p - coordinates of matched points in the first image
			q - coordinates of matched points in the second image
			K1 - intrinsic matrix of the camera corresponding to the first view
			K2 - intrinsic matrix for the second view
			
Note: To compute fundamental matrix, initialize the intrinsic matrix as an identity 3x3 matrix
	  
### test_synth
Test of normalized 8-point algorithm in MATLAB

### test_epilines
Test of normalized 8-point algorithm on images from KITTI sequence. Epipolar lines of the given image pair will be overlayed onto the images. Below is an example.

<img src="images/example1.png" width="413" height="150" align="middle"><img src="images/example2.png" width="413" height="150" align="middle">

## Reference

	[1] R. Hartley, "In defense of the eight-point algorithm", IEEE Transactions on Pattern Analysis and 
	Machine Intelligence, vol. 19, no. 6, pp. 580-593, 1997.
