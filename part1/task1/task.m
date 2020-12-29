load('data/example_image.mat');

filename = 'data/image.sim';
%
simple_image_write(vol,voxdims,filename);

[image, dims] = simple_image_read(filename,vol,voxdims);
%%
xaxis = dims(1)* 0:223;
yaxis = dims(2)* 0:223;

figure;
imagesc(xaxis,yaxis,image(:,:,15));
colormap gray;
colorbar;

