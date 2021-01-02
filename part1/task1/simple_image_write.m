function simple_image_write(vol,voxdims,output_filename);


binary_file = fopen(output_filename,'w');

fwrite(binary_file,voxdims,'float32');

fseek(binary_file,0,'cof');

fwrite(binary_file,vol,'int16');
fclose(binary_file);


