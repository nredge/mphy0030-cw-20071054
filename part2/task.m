clearvars;
% loads in image data: volume intensity values and voxel dimensions
load('data/example_image.mat');

% creates an object of the Image3D class using the image data
objImage3D = Image3D(vol,voxdims);

% sets the number of control points in each x, y, z direction
num = [4 4 4];

% sets the range to be an empty array so that the FreeFormDeformation constructor 
% uses the 'optional' constructor with Image3D object
range = [];

% sets the strength of the random_transform_generator: 0-1
rand_strength = 1; 

% lambda is used as the localization paramter. A small value is needed to
% retain locality
lambda = 0.01;

% sets the Gaussian kernel parameter
sigma = 2;

% generates 5 random z values for plotting
z = randi([1,30],1,5);

% runs random_trasnform 10 times to generate ten images, with the 5
% different z values being plotted for each image.
for ii = 1
    F = FreeFormDeformation.random_transform(objImage3D,num,range,rand_strength,lambda,sigma);
    F = permute(F,[2 1 3]);
    
    figure;
    for jj = 1:5
        subplot(1,5,jj);
        imagesc(F(:,:,z(jj)));
        colormap gray;
    end
end
%%
% rand_strength = 0.5;
% num = [5 5 5];
% sigma = 1;