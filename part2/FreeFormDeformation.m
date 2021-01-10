classdef FreeFormDeformation
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function control = untitled6(num,range)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            x = linspace(range(1,1),range(1,2),num(1));
            y = linspace(range(2,1),range(2,2),num(2));
            z = linspace(range(3,1),range(3,2),num(3));
            
            control = zeros(max(num),3);
            for ii = 1:max(num)
               control(ii,:) = [x(ii),y(ii),z(ii)]; 
            end
        end
        
        function controlimg = un(image3d,num)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            x = linspace(image3d.range(1,1),image3d.range(1,2),num(1));
            y = linspace(image3d.range(2,1),image3d.range(2,2),num(2));
            z = linspace(image3d.range(3,1),image3d.range(3,2),num(3));
            
            controlimg = zeros(max(num),3);
            for ii = 1:max(num)
               controlimg(ii,:) = [x(ii),y(ii),z(ii)]; 
            end
        end
        
        function rdm_control = random_transform_generator()
            
        end
        
        function warp = warp_image(image3d.obj,rfbspline.obj)
            
        end
        
        function random_transform()
            
        end
    end
end

