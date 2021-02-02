classdef Image3D
    % Class that takes image data vol & voxdims and creates an object that
    % contains various properties fo the image. These properties are the
    % range of values in mm for each dimension of the image. Tis is later
    % used for computer control point coordinates. x, y,
    % z are arrays of the x, y, and z axis in mm for the image. X, Y,
    % Z are meshgrids of all of the coordiantes in the image. Vol is the
    % intesity values of the image volume
    
    properties
        
        range
        x
        y
        z
        X
        Y
        Z
        vol
    end
    
    methods
        function image3d = Image3D(vol,voxdims)
            % Constructs an object of this class using vol - a 3D matrix, and
            % voxdims - an array of 3 values listing voxel dimensions in x, y and z.
            sz = size(vol);
            
            % Creates array for the x,y,z axis in mm using the vol sizes and voxel
            % dimensions
            image3d.x = (0:sz(1)-1)*voxdims(1);
            image3d.y = (0:sz(2)-1)*voxdims(2);
            image3d.z = (0:sz(3)-1)*voxdims(3);
            
            % creates a meshgrid of coordinates for all points in the image
           [image3d.X,image3d.Y,image3d.Z] = meshgrid(image3d.x,image3d.y,image3d.z);
           image3d.vol = vol;
            
           % obtain the min and max in each direction to form the range of
           % values
            min_x = min(image3d.x);
            max_x = max(image3d.x);
            min_y = min(image3d.y);
            max_y = max(image3d.y);
            min_z = min(image3d.z);
            max_z = max(image3d.z);
            image3d.range = [min_x,max_x;min_y,max_y;min_z,max_z];
           
        end
        
        
    end
end

