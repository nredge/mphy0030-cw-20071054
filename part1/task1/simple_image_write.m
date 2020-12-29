function simple_image_write(vol,voxdims,output_filename);


binary_file = fopen(output_filename,'w');

fwrite(binary_file,vol,'int16');
fclose(binary_file);

binary_file = fopen(output_filename,'a');
fseek(binary_file,3010560,'bof');
fwrite(binary_file,voxdims,'float32');
fclose(binary_file);