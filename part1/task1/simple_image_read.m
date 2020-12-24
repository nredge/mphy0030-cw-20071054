function simple_image_read(input_filename,vol);

sz = size(vol);

binary_file = fopen(input_filename);
fread(binary_file,sz,'int16')
