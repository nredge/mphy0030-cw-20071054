% load in image data, volume data, vol, and voxel dimensions, voxdims
load('data/example_image.mat'); 

filename = 'data/image.sim'; % set filename for binary file to be saved in data folder

simple_image_write(vol,voxdims,filename); % write vol & voxdims to a binary file

[image, dims] = simple_image_read(filename,vol,voxdims); % read binary file back into variables

xaxis = dims(1)* 0:223; % create axis array for plots by multiplying voxel dimensions
yaxis = dims(2)* 0:223; % by array of x & y dimensions

image = permute(image,[2 1 3]); % swap x & y dimensions to obtain correction orientation
% as matlab reads column-wise the image appears rotated by 90 degress (x &
% y swapped) unless permute is used

z = randi(30,[1,3]); % select 3 random z values from the 30 z slices for plotting
%% 
% create three figures, each plotting the image in the x-y plane at a different z value each
% each plot utilises a grey-scale to display  the intensity values
figure;
imagesc(xaxis,yaxis,image(:,:,z(1)));
colormap gray;
xlabel('x-dimension');
ylabel('y-dimension');
title(sprintf('Plot at z=%d', z(1)));
colorbar;

figure;
imagesc(xaxis,yaxis,image(:,:,z(2)));
colormap gray;
xlabel('x-dimension');
ylabel('y-dimension');
title(sprintf('Plot at z=%d', z(2)));
colorbar;

figure;
imagesc(xaxis,yaxis,image(:,:,z(3)));
colormap gray;
xlabel('x-dimension');
ylabel('y-dimension');
title(sprintf('Plot at z=%d', z(3)));
colorbar;