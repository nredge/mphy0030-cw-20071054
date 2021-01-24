classdef Image3D
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        range
        XCoords
        YCoords
        ZCoords
        X
        Y
        Z
    end
    
    methods
        function image3d = Image3D(vol,voxdims)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            sz = size(vol);
            ind = numel(vol);
            
            image3d.XCoords = (0:sz(1)-1)*voxdims(1);
            image3d.YCoords = (0:sz(2)-1)*voxdims(2);
            image3d.ZCoords = (0:sz(3)-1)*voxdims(3);
           [image3d.X,image3d.Y,image3d.Z] = meshgrid(image3d.XCoords,image3d.YCoords,image3d.ZCoords);
           
%             image3d.coords = zeros(prod(sz),3);
%             for ii = 1:prod(sz)
%                image3d.coords(ii,:) = [XCoords(ii),YCoords(ii),ZCoords(ii)]; 
%             end
%             
            min_x = min(image3d.XCoords);
            max_x = max(image3d.XCoords);
            min_y = min(image3d.YCoords);
            max_y = max(image3d.YCoords);
            min_z = min(image3d.ZCoords);
            max_z = max(image3d.ZCoords);
            image3d.range = [min_x,max_x;min_y,max_y;min_z,max_z];
           
        end
        
        
    end
end

