clearvars;
load('data/example_image.mat');

objImage3D = Image3D(vol,voxdims);

num = [5 5 5];

rand_strength = 0.5; 

lambda=0.001;
sigma = 1;

F = FreeFormDeformation.random_transform(objImage3D,num,rand_strength,lambda,sigma);

%%

% 
% %%
% figure;
% imagesc(F(:,:,11)');
% 


