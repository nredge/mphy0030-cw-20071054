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
        control;
    end
    
    methods
        function obj = FreeFormDeformation(num,range,objImage3D)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            
            if isempty(objImage3D) == 1
            obj.x = linspace(range(1,1),range(1,2),num(1));
            obj.y = linspace(range(2,1),range(2,2),num(2));
            obj.z = linspace(range(3,1),range(3,2),num(3));
            [obj.X,obj.Y,obj.Z] = meshgrid(obj.x,obj.y,obj.z);
            
            obj.control = zeros(prod(num),3);
            for ii = 1:prod(num)
               obj.control(ii,:) = [obj.X(ii),obj.Y(ii),obj.Z(ii)]; 
            end
            
            elseif isempty(range) == 1
            obj.x = linspace(objImage3D.range(1,1),objImage3D.range(1,2),num(1));
            obj.y = linspace(objImage3D.range(2,1),objImage3D.range(2,2),num(2));
            obj.z = linspace(objImage3D.range(3,1),objImage3D.range(3,2),num(3));
            
            [obj.X,obj.Y,obj.Z] = meshgrid(obj.x,obj.y,obj.z);
            
            obj.control = zeros(prod(num),3);
            for ii = 1:prod(num)
               obj.control(ii,:) = [obj.X(ii),obj.Y(ii),obj.Z(ii)]; 
            end
            
            end
        end
        
    end    
    
     methods (Static)  
         
        function target = random_transform_generator(num,source,range,strength)
            target = zeros(size(source));
            
            for ii = 1:prod(num)
            
            dx = strength * 5*randn(1,1);
            dy = strength * 5*randn(1,1);
            dz = strength * 5*randn(1,1);
            
            
            target(ii,1) = source(ii,1) + dx;
            target(ii,2) = source(ii,2) + dy;
            target(ii,3) = source(ii,3) + dz;
           
            if target(ii,1) < range(1,1)  
                target(ii,1) = range(1,1);
                
            elseif target(ii,1) > range(1,2)
                target(ii,1) = range(1,2);
            end
            
            if  target(ii,2) < range(2,1)
                
             target(ii,2) = range(2,1);
             
            elseif target(ii,2) > range(2,2)
                
                    target(ii,2) = range(2,2);
            end
            
            if target(ii,3) < range(3,1)
                
             target(ii,3) = range(3,1);
             
            elseif target(ii,3) > range(3,2)   
                target(ii,3) = range(3,2); 
            end
            
            end
            
        end
        
        function F = warp_image(objImage3D,objFFD,objRBF,sigma)
            
            
            
            [u_x,u_y,u_z] = RBFSpline.evaluate(objImage3D.x,objImage3D.y,objImage3D.z,objFFD.control,objRBF.alpha,sigma);
            vol_dbl = cast(objImage3D.vol,'double');
 
%             [Ux,Uy,Uz] = meshgrid(sort(u_x),sort(u_y),sort(u_z));
            [Ux,Uy,Uz] = meshgrid(u_x,u_y,u_z);

            F = interp3(objImage3D.X,objImage3D.Y,objImage3D.Z,vol_dbl,Ux,Uy,Uz);

    
        end
        
        function F = random_transform(objImage3D,num,range,rand_strength,lambda,sigma)
            
           objFFD = FreeFormDeformation(num,range,objImage3D);
            target_pts = FreeFormDeformation.random_transform_generator(num,objFFD.control,objImage3D.range,rand_strength);
            objRBF = RBFSpline(objFFD.control,target_pts,lambda,sigma);
            F = FreeFormDeformation.warp_image(objImage3D,objFFD,objRBF,sigma);
            
            
            
        end
    
   
    end
end

