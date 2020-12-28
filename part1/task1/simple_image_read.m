function image = simple_image_read(input_filename,vol);

vol_el = numel(vol);
vol_sz = size(vol);

binary_file = fopen(input_filename);
image = fread(binary_file,vol_el,'int16');

image = reshape(image,vol_sz);

fclose(binary_file);