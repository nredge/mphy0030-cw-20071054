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
            %Construct an instance of this class with number of required
            %control points in each direction (x, y, z) in a [1,3] vector,
            %the range in mm the control points in a [3,2] matrix where
            %each row is x, y, z and the columns are the min and max value,
            %and an object of Image3D. The output is an object that
            %contains the coordinates of the control point
           
            % num is always required, but either range or objImage3D can be
            % used. Therefore, the one not being used must be set as =[],
            % an empty array. The constructor will check which is empty,
            % and use the other to construct the object
            
            % if objImage3D is empty, vectors for the x, y and z coords for the
            % control points are created using the number of points and their range, then a meshgrid is made using
            % these
            if isempty(objImage3D) == 1
            obj.x = linspace(range(1,1),range(1,2),num(1));
            obj.y = linspace(range(2,1),range(2,2),num(2));
            obj.z = linspace(range(3,1),range(3,2),num(3));
            [obj.X,obj.Y,obj.Z] = meshgrid(obj.x,obj.y,obj.z);
            
            % creates a list of point coords in a [n,3] matrix for input in
            % other functions
            obj.control = zeros(prod(num),3);
            for ii = 1:prod(num)
               obj.control(ii,:) = [obj.X(ii),obj.Y(ii),obj.Z(ii)]; 
            end
            
            % same method but uses range data from objImage3D instead
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
         
        function target = random_transform_generator(num,control,range,strength)
            % function that takes number of control points in [1,3] (column
            % for each of x, y, z), list of control points coordinates, the
            % range of the image's dimensions, and the strength of the
            % randomisation. The output is a lost of coordinates of the
            % dispalced control points, referred to as target points.
            
            % intialise matrix for target points
            target = zeros(size(control));
            
            % loop that for each control point, creates a random
            % displacement in x, y, and z, then applies the displacement.
            % The displacements are drawn fron a normal distribution,
            % mulitpled by 5 so that they're are not too small, and
            % multipled by the strength parameter. If strength is zero, no
            % displacement will be added so transformation will be an
            % identity transformation.
            for ii = 1:prod(num)
            
            dx = strength * 5*randn(1,1);
            dy = strength * 5*randn(1,1);
            dz = strength * 5*randn(1,1);
            
            
            target(ii,1) = control(ii,1) + dx;
            target(ii,2) = control(ii,2) + dy;
            target(ii,3) = control(ii,3) + dz;
           
            % checks to see if displaced points are outisde range of image
            % dimensions. If so, sets the points to be at the edge
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
        
        function warped = warp_image(objImage3D,objFFD,objRBF,sigma)
            % function that takes an object from Image3D class,
            % FreeFormDeformation class, and RBFSpline class, as well as a
            % sigma value. The output is the warped image intensity values
            % in a 3D matrix
            
            % calls the evaluate function from RBFSpline to create
            % vectors of transformed coordinates
            [u_x,u_y,u_z] = RBFSpline.evaluate(objImage3D.x,objImage3D.y,objImage3D.z,objFFD.control,objRBF.alpha,sigma);
            
            % changes the vol data from int 16 to double for use in
            % interpolation 
            vol_dbl = cast(objImage3D.vol,'double');
 
            % creates a meshgrid of all the transformed coordinates
            [Ux,Uy,Uz] = meshgrid(u_x,u_y,u_z);

            % uses interpolation with original coordinates, original
            % intensity values, and new coordiantes, to create a new volume
            % of intensity values.
            warped = interp3(objImage3D.X,objImage3D.Y,objImage3D.Z,vol_dbl,Ux,Uy,Uz);

    
        end
        
        function F = random_transform(objImage3D,num,range,rand_strength,lambda,sigma)
            % function that takes an Image3D object, the number of control
            % points in each direction in [1,3] format, the range the
            % control points occupy [3,2] (set to empty [] if using objImage3D
            % instead for FFD constructor), strength for
            % random_transform_generator, lambda value and sigma value.
            
            % calls FFD constructor to create object of FFD of control
            % points
           objFFD = FreeFormDeformation(num,range,objImage3D);
           
           % creates randomly displaced control points
            target_pts = FreeFormDeformation.random_transform_generator(num,objFFD.control,objImage3D.range,rand_strength);
            
            % creates RBFSpline object of alpha coefficients
            objRBF = RBFSpline(objFFD.control,target_pts,lambda,sigma);
            
            % calls warp_image function to obtain a new image volume
            F = FreeFormDeformation.warp_image(objImage3D,objFFD,objRBF,sigma);
            
            
            
        end
    
   
    end
end

