load('data/example_image.mat');

filename = 'example_image.sim';

simple_image_write(vol,filename);

image = simple_image_read(filename,vol);
%%
xaxis = voxdims(1)* 0:223;
yaxis = voxdims(2)* 0:223;

figure;
imagesc(xaxis,yaxis,image(:,:,5));
colormap gray;
colorbar;

