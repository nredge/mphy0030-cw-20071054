clearvars;
load('data/example_image.mat');

objImage3D = Image3D(vol,voxdims);
%%
num = [4 4 4];
objFFD = FreeFormDeformation.image_source(objImage3D.range,num);
%%
rand_strength = 0.5; % 0-1
target_pts = FreeFormDeformation.random_transform_generator(num,objFFD.image_control,objImage3D.range,rand_strength);
%%
lambda=0.01;

alpha = RBFSpline.fit(objFFD.image_control,target_pts.control,lambda);
%%
sigma = 0.8;
[ux,uy,uz] = RBFSpline.evaluate(objImage3D.XCoords,objImage3D.YCoords,objImage3D.ZCoords,objFFD.image_control,alpha,sigma);