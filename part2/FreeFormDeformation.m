classdef FreeFormDeformation
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x;
        y;
        z;
        X;
        Y;
        Z;
    end
    
    methods
        function obj = FreeFormDeformation(num,range)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            obj.x = linspace(range(1,1),range(1,2),num(1));
            obj.y = linspace(range(2,1),range(2,2),num(2));
            obj.z = linspace(range(3,1),range(3,2),num(3));
            [obj.X,obj.Y,obj.Z] = meshgrid(obj.x,obj.y,obj.z);
            
            obj.control = zeros(prod(num),3);
            for ii = 1:prod(num)
               obj.control(ii,:) = [obj.X(ii),obj.Y(ii),obj.Z(ii)]; 
            end
        end
        
    end    
    
     methods (Static)  
         
         function obj = image_source(range,num)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.x = linspace(range(1,1),range(1,2),num(1));
            obj.y = linspace(range(2,1),range(2,2),num(2));
            obj.z = linspace(range(3,1),range(3,2),num(3));
            
            [obj.X,obj.Y,obj.Z] = meshgrid(obj.x,obj.y,obj.z);
            
            obj.image_control = zeros(prod(num),3);
            for ii = 1:prod(num)
               obj.image_control(ii,:) = [obj.X(ii),obj.Y(ii),obj.Z(ii)]; 
            end
        end 
         
         
        function target = random_transform_generator(num,source,range,strength)
            target.control = zeros(size(source));
            
            for ii = 1:prod(num)
                
                pos_neg = 2*randi([0 1],1) - 1;
            
            target.dx = strength * pos_neg* randi([range(1,1),round(range(1,2))],1,1);
            target.dy = strength * pos_neg* randi([range(2,1),round(range(2,2))],1,1);
            target.dz = strength * pos_neg* randi([range(3,1),round(range(3,2))],1,1);
            
            
            target.control(ii,1) = source(ii,1) + target.dx;
            target.control(ii,2) = source(ii,2) + target.dy;
            target.control(ii,3) = source(ii,3) + target.dz;
           
            if target.control(ii,1) < range(1,1)  
                target.control(ii,1) = range(1,1);
                
            elseif target.control(ii,1) > range(1,2)
                target.control(ii,1) = range(1,2);
            end
            
            if  target.control(ii,2) < range(2,1)
                
             target.control(ii,2) = range(2,1);
             
            elseif target.control(ii,2) > range(2,2)
                
                    target.control(ii,2) = range(2,2);
            end
            
            if target.control(ii,3) < range(3,1)
                
             target.control(ii,3) = range(3,1);
             
            elseif target.control(ii,3) > range(3,2)   
                target.control(ii,3) = range(3,2); 
            end
            
            end
            
        end
        
        function warp = warp_image(image3d,source,target,sigma)
            control = image_source(image3d,num)
            u = evaluate(obj,x,control,alpha,sigma);
            
        end
        
        function random_transform(source,target)
            
            RBFSpline.fit(source,target,lambda)
        end
    
   
    end
end

