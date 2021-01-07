classdef RBFSpline
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = 
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function alpha = fit(obj,source,target,lambda,sigma)
            
            p_sz = size(source); % source list of coords for each point 
            n = sz(1);
            K = zeros(n);
            W = zeros(n);
%             Rg = exp(-r^2/(2*sigma^2));
            alpha = zeros(3,n);
           for ii = 1:n
            for jj = 1:n
               r = norm(source(ii,1) - source(jj,1));
               K(ii,jj) = exp(-r^2/(2*sigma(ii)^2));
            end
           end
           for ii = 1:n
              W(ii,ii) = 1/(sigma(ii)^2); 
           end
           q1 = target(:,1);
           q2 = target(:,2);
           q3 = target(:,3);
        %Ax = b, least squares problem: (K+lambda*W^-1)Alpha = q_k
          mat = (K + lambda*inv(W))' * (K + lambda*inv(W));
          
          vec1 = (K + lambda*inv(W))' * q1;
          mat1 = cat(2,mat,vec1);
          mat1 = rref(mat1);
          alpha(1,:) = mat1;
         
          vec2 = (K + lambda*inv(W))' * q2;
          mat2 = cat(2,mat,vec2);
          mat2 = rref(mat2);
          alpha(2,:) = mat2;
          
          vec3 = (K + lambda*inv(W))' * q3;
          mat3 = cat(2,mat,vec3);
          mat3 = rref(mat3);
          alpha(3,:) = mat3;
        
        end
        
        function transformed = evaluate(obj,query,control,alpha,parameters)
            
        end
        
        function K = kernel_gaussian(obj,query,control,parameters)
            
        end
    end
end

