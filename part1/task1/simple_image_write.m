% function to write volume data and voxel dimensions into a binary file
% format. The inputs are the volume data, the voxel dimensions, and the
% write filename
function simple_image_write(vol,voxdims,filename); 


binary_file = fopen(filename,'w'); % opens a binary file format in write mode, given the chosen filename

fwrite(binary_file,voxdims,'float32'); % writes the voxel dimensions to the file as float32

fseek(binary_file,0,'cof'); % sets the file to stay at the current position on the open file

fwrite(binary_file,vol,'int16'); % writes the volume data at int16
fclose(binary_file); % closes the binary file


