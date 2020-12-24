function simple_image_write(vol,output_filename);

binary_file = fopen(output_filename,'w');

fwrite(binary_file,vol,'int16');
fclose(binary_file);