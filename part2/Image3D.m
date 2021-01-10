classdef Image3D
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        sz
        range
    end
    
    methods
        function image3d = untitled6(vol,voxdims)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            image3d.sz = size(vol);
            image3d.ind = numel(vol);
            [row,col,slice] = ind2sub(image3d.sz,1:image3d:ind);
            points = zeros(image3d.ind,3);
            for ii = 1:image3d.ind
                points(ii,:) = [row(ii)*voxdims(1),col(ii)*voxdims(2),slice(ii)*voxdims(3)];
            end
            min_x = min(points(:,1);
            max_x = max(points(:,1);
            min_y = min(points(:,2);
            max_y = max(points(:,2);
            min_z = min(points(:,3);
            max_z = max(points(:,3);
            image3d.range = [min_x,max_x;min_y,max_y;min_z,max_z];
           
        end
        
        
    end
end

