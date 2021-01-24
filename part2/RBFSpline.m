classdef RBFSpline
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
%     properties
%         alpha
%     end
    
    methods (Static)
%         function obj = 
%             %UNTITLED2 Construct an instance of this class
%             %   Detailed explanation goes here
%             obj.Property1 = inputArg1 + inputArg2;
%         end
        
        function alpha = fit(source,target,lambda)
            sigma = 5;
            p_sz = size(source); % source list of coords for each point 
            n = p_sz(1);
%             W = zeros(n);
%            
            alpha = zeros(3,n);
           [K_x,K_y,K_z] = RBFSpline.kernel_gaussian(source(:,1)',source(:,2)',source(:,3)',source,sigma);
%            for ii = 1:n
%               W(ii,ii) = 1/(sigma(ii)^2); 
%            end
           q1 = target(:,1);
           q2 = target(:,2);
           q3 = target(:,3);
           
        %Ax = b, least squares problem: (K+lambda*W^-1)Alpha = q_k. x =
        %pinv(A)*b
          A_x = (K_x + lambda*eye(n));
          A_y = (K_y + lambda*eye(n));
          A_z = (K_z + lambda*eye(n));
%           
          alpha(1,:) = pinv(A_x)*q1;
         
%         
          alpha(2,:) =pinv(A_y)*q2;
          
%          
          alpha(3,:) = pinv(A_z)*q3;
        
        end
        
        function [u_x,u_y,u_z] = evaluate(x,y,z,control,alpha,sigma)
            
       [K_x,K_y,K_z] = RBFSpline.kernel_gaussian(x,y,z,control,sigma);
            
          K_x = alpha(1,:) .* K_x; 
            K_y = alpha(2,:) .* K_y; 
            K_z = alpha(3,:) .* K_z;
            
            u_x = x' + sum(K_x,2);
            u_y = y' + sum(K_y,2);
            u_z = z' + sum(K_z,2);
        end
        
        function [K_x,K_y,K_z] = kernel_gaussian(x,y,z,control,sigma)
            
            m = size(x,2); % source list of coords for each point 
            l = size(control,1);
            
            r_x = x'-control(:,1)';
            r_y = y'-control(:,2)';
            r_z = z'-control(:,3)';
            
            
%             R = zeros(m,l);
%             for ii = 1:(m*l)
%                 R(ii) = norm([r_x(ii) r_y(ii) r_z(ii) ]);
%                 
%             end
            K_x = exp(-r_x.^2 ./(2*sigma^2));
            K_y = exp(-r_y.^2 ./(2*sigma^2));
            K_z = exp(-r_z.^2 ./(2*sigma^2));
          
            
        end
    end
end

