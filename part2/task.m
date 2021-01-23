clearvars;
load('data/example_image.mat');

objImage3D = Image3D(vol,voxdims);
%%
num = [10 10 5];
objFFD = FreeFormDeformation.image_source(objImage3D.range,num);
%%
rand_strength = 0.5; % 0-1
target_pts = FreeFormDeformation.random_transform_generator(num,objFFD.image_control,objImage3D.range,rand_strength);
%%
lambda=0.001;

alpha = RBFSpline.fit(objFFD.image_control,target_pts.control,lambda);
%%
sigma = 0.1;
[u_x,u_y,u_z] = RBFSpline.evaluate(objImage3D.XCoords,objImage3D.YCoords,objImage3D.ZCoords,objFFD.image_control,alpha,sigma);
%%
[Ux,Uy,Uz] = meshgrid(u_x,u_y,u_z);

%%
Ux1 = Ux(:,:,15);
Uy1 = Uy(:,:,15);
Uz1 = Uz(:,:,15);


