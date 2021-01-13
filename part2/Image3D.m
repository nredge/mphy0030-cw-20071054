classdef Image3D
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        sz
        ind
        range
        X
        Y
        Z
    end
    
    methods
        function image3d = image(vol,voxdims)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            image3d.sz = size(vol);
            image3d.ind = numel(vol);
            
            x = 0:image3d.sz(1)*voxdims(1);
            y = 0:image3d.sz(2)*voxdims(2);
            z = 0:image3d.sz(3)*voxdims(3);
           [image3d.X,image3d.Y,image3d.Z] = meshgrid(x,y,z);
           
%             [row,col,slice] = ind2sub(image3d.sz,1:image3d:ind);
%             image3d.points = zeros(image3d.ind,3);
%             for ii = 1:image3d.ind
%                 image3d.points(ii,:) = [row(ii)*voxdims(1),col(ii)*voxdims(2),slice(ii)*voxdims(3)];
%             end
            min_x = min(x);
            max_x = max(x);
            min_y = min(y);
            max_y = max(y);
            min_z = min(z);
            max_z = max(z);
            image3d.range = [min_x,max_x;min_y,max_y;min_z,max_z];
           
        end
        
        
    end
end

