function [image,dims] = simple_image_read(input_filename,vol,voxdims);

vol_el = numel(vol);
vol_sz = size(vol);
dims_sz = size(voxdims);

binary_file = fopen(input_filename);
image = fread(binary_file,vol_el,'int16');

fseek(binary_file,0,'cof');
dims = fread(binary_file,dims_sz,'float32');

fclose(binary_file);

image = reshape(image,vol_sz);