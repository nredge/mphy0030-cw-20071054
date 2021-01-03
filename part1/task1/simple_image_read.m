% function to read volume data and voxel dimensions from a binary file
% format. The inputs are the filename, the volume data, and the voxel dimensions
function [image,dims] = simple_image_read(filename,vol,voxdims);

vol_el = numel(vol); % the number of elements in the volume data matrix
vol_sz = size(vol); % the size of the volume data matrix i.e the dimensions
dims_sz = size(voxdims); % the size of the voxel dimensions array

binary_file = fopen(filename); % opens the chosen binary file

dims = fread(binary_file,dims_sz,'float32'); % reads in the first set of float32 data that fits an array of the same size and voxdims array

fseek(binary_file,0,'cof'); % sets the file to stay at the current position on the open file

image = fread(binary_file,vol_el,'int16'); % reads in the data in int16 that is fit into an array wit the same number of elements of the volume data,
% as a 3D matrix cannot be read in, so is read into an 1D array

fclose(binary_file); % close the binary file

image = reshape(image,vol_sz); % reshape the read in volume data to be the same size as the original volume data matrix