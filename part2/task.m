clearvars;
load('data/example_image.mat');

objImage3D = Image3D(vol,voxdims);
%%
num = [5 5 5];
objFFD = FreeFormDeformation.image_source(objImage3D.range,num);
%%
rand_strength = 0.5; % 0-1
target_pts = FreeFormDeformation.random_transform_generator(num,objFFD.image_pts,objImage3D.range,rand_strength);
%%
lambda=0.01;

alpha = RBFSpline.fit(objFFD.image_pts,target_pts.control,lambda);