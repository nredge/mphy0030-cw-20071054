classdef FreeFormDeformation
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = untitled6(num,range)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = linspace(range(1,1),range(1,2),num(1));
            obj.Property2 = linspace(range(2,1),range(2,2),num(2));
            obj.Property3 = linspace(range(3,1),range(3,2),num(3));
        end
        
        function optional_obj = un(image3d.obj,num_control)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
        function random = random_transform_generator()
            
        end
        
        function warp = warp_image(image3d.obj,rfbspline.obj)
            
        end
        
        function random_transform()
            
        end
    end
end

