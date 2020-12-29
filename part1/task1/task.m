load('data/example_image.mat');

filename = 'data/image.sim';
%
simple_image_write(vol,voxdims,filename);

[image, dims] = simple_image_read(filename,vol,voxdims);
%%
xaxis = dims(1)* 0:223;
yaxis = dims(2)* 0:223;

image = permute(image,[2 1 3]);

figure;
imagesc(xaxis,yaxis,image(:,:,25));
colormap gray;
colorbar;

