classdef RBFSpline
    % RBFSpline class contains all the functions necessary to compute a
    % transformed coordinate set, utilising a Gaussian RBF spline. The only
    % property it contains are the alpha coefficients
    
    properties
        alpha
        
    end
    
    methods 
        function obj = RBFSpline(source,target,lambda,sigma)
            % Class constructor that takes source points, target points,
            % lambda and sigma. Alpha coefficients are computed using the
            % fit function
            obj.alpha = RBFSpline.fit(source,target,lambda,sigma);

        end
    end
    
    methods (Static)
        function alpha = fit(source,target,lambda,sigma)
            % function that takes in source points, target points(which are both [n,3] matrices of x,y,z coords), lambda,
            % and sigma (which are both singular numbers), and outputs the alpha coefficients ([3,n] matrix of cooefficients). Each row of
            % alpha corresponds to x, y, and z respectively 
            
            % obtain number of points in source points 
            n = size(source,1);

            % initalise an empty matrix to store alpha values
            alpha = zeros(3,n);
            
            % call kernel_gaussian function computer K matrices using
            % source coordinates as both control and target points in the
            % kernel
           [K_x,K_y,K_z] = RBFSpline.kernel_gaussian(source(:,1)',source(:,2)',source(:,3)',source,sigma);
            
           % for ease in following code, split x, y, and z of the target
           % points into q's
           q1 = target(:,1);
           q2 = target(:,2);
           q3 = target(:,3);
           
        %Ax = b, least squares problem: (K+lambda*I)*Alpha = q_k. Solve using Moore-Penrose inverse 
        %x = pinv(A)*b as gives minimsed Euclidean norm. These are the
        %system of linear equation outlined in Qu2 of the report.
          A_x = (K_x + lambda*eye(n));
          A_y = (K_y + lambda*eye(n));
          A_z = (K_z + lambda*eye(n));
           
          alpha(1,:) = pinv(A_x)*q1;
                 
          alpha(2,:) = pinv(A_y)*q2;
                    
          alpha(3,:) = pinv(A_z)*q3;
        
        end
        
        function [u_x,u_y,u_z] = evaluate(x,y,z,control,alpha,sigma)
         % function that takes in x, y, z coordinates as vectors of the query set, a [n,3] matrix of coordiantes for the control set,
         % and alpha and sigma values. Alpha is a [3,n] matrix where each
         % row correspons to x, y, z. Sigma is a single value. The output
         % are vectors of transformed x, y and z.
         
         % calls kernel_gaussian function compute K kernel matrices
       [K_x,K_y,K_z] = RBFSpline.kernel_gaussian(x,y,z,control,sigma);
            
       % u = sum(alpha * R(r)), where each element in K is the
       % corresponding R. Therefore, the matrices are multiplied by their
       % respetive alpha coefficients and each row is summed, then added to
       % the original coordiante.
          K_x = alpha(1,:) .* K_x; 
            K_y = alpha(2,:) .* K_y; 
            K_z = alpha(3,:) .* K_z;
            
            u_x = x' + sum(K_x,2);
            u_y = y' + sum(K_y,2);
            u_z = z' + sum(K_z,2);
        end
        
        function [K_x,K_y,K_z] = kernel_gaussian(x,y,z,control,sigma)
            % function takes in vectors of x, y, z query coordinates, [n,3]
            % matrix of control coordiantes (each column is x, y, z), and a
            % single value sigma. The output are three K matrices of [m,n]
            % size where m is the number of query points in x,y or z, and n
            % is the number of control points.
            
           
            % computes difference between the each of the x, y and z coordinates of
            % query and control sets, results in a matrix with query points
            % chagning along the rows, and control points changing along the column
            r_x = norm(x'-control(:,1)');
            r_y = norm(y'-control(:,2)');
            r_z = norm(z'-control(:,3)');
            
            % computes the Gaussian RBF using the r matrices to generate K
            % matrices.
            K_x = exp(-r_x.^2 ./(2*sigma^2));
            K_y = exp(-r_y.^2 ./(2*sigma^2));
            K_z = exp(-r_z.^2 ./(2*sigma^2));
          
            
        end
    end
end

