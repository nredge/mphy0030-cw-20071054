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
        function obj = source(num,range)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            obj.x = linspace(range(1,1),range(1,2),num(1));
            obj.y = linspace(range(2,1),range(2,2),num(2));
            obj.z = linspace(range(3,1),range(3,2),num(3));
            [obj.X,obj.Y,obj.Z] = meshgrid(obj.x,obj.y,obj.z);
            
%             control = zeros(max(num),3);
%             for ii = 1:max(num)
%                control(ii,:) = [x(ii),y(ii),z(ii)]; 
%             end
        end
        
        function obj = image_source(image3d,num,range)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.x = linspace(range(1,1),range(1,2),num(1));
            obj.y = linspace(range(2,1),range(2,2),num(2));
            obj.z = linspace(range(3,1),range(3,2),num(3));
            
            [obj.X,obj.Y,obj.Z] = meshgrid(obj.x,obj.y,obj.z);
            
%             image_pts = zeros(max(num),3);
%             for ii = 1:max(num)
%                image_pts(ii,:) = [obj.x(ii),obj.y(ii),obj.z(ii)]; 
%             end
        end
        
        function rdm_control = random_transform_generator(num,image3d,strength)
            rand_control = zeros(num,3);
            
%             d_x = strength * randi([image3d.range(1,1),image3d.range(1,2)],num,1);
%             d_y = strength * randi([image3d.range(2,1),image3d.range(2,2)],num,1);
%             d_z = strength * randi([image3d.range(3,1),image3d.range(3,2)],num,1);
%             2*randi([0 1],1) - 1;
            for ii = 1:num
            sign = 2*randi([0 1],1) - 1;
            rand_control(ii,1) = control(ii,1) + strength * sign* randi([image3d.range(1,1),image3d.range(1,2)],num,1);
            rand_control(ii,2) = control(ii,2) + strength * sign* randi([image3d.range(2,1),image3d.range(2,2)],num,1);
            rand_control(ii,3) = control(ii,3) + strength * sign* randi([image3d.range(3,1),image3d.range(3,2)],num,1);
           
            if rand_control(ii,1) < image3d.range(1,1)  
                rand_control(ii,1) = image3d.range(1,1);
                
            elseif rand_control(ii,1) > image3d.range(1,2)
                rand_control(ii,1) = image3d.range(1,2);
            end
            
            if  rand_control(ii,2) < image3d.range(2,1)
                
             rand_control(ii,2) = image3d.range(2,1);
             
            elseif rand_control(ii,2) > image3d.range(2,2)
                
                    rand_control(ii,2) = image3d.range(2,2);
            end
            
            if rand_control(ii,3) < image3d.range(3,1)
                
             rand_control(ii,3) = image3d.range(3,1);
             
            elseif rand_control(ii,3) > image3d.range(3,2)   
                rand_control(ii,3) = image3d.range(3,2); 
            end
            
            end
            
        end
        
        function warp = warp_image(image3d,rfbspline,sigma)
            control = image_source(image3d,num)
            u = evaluate(obj,x,control,alpha,sigma);
            
        end
        
        function random_transform()
            
        end
    end
end

