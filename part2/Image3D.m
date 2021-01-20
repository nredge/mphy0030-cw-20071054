classdef Image3D
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        range
        XCoords
        YCoords
        ZCoords
%         coords
    end
    
    methods
        function image3d = Image3D(vol,voxdims)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            sz = size(vol);
            ind = numel(vol);
            
            x = (0:sz(1)-1)*voxdims(1);
            y = (0:sz(2)-1)*voxdims(2);
            z = (0:sz(3)-1)*voxdims(3);
           [image3d.XCoords,image3d.YCoords,image3d.ZCoords] = meshgrid(x,y,z);
           
%             image3d.coords = zeros(prod(sz),3);
%             for ii = 1:prod(sz)
%                image3d.coords(ii,:) = [image3d.XCoords(ii),image3d.YCoords(ii),image3d.ZCoords(ii)]; 
%             end
%             
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

