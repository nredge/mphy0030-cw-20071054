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
            sigma = 1;
            p_sz = size(source); % source list of coords for each point 
            n = p_sz(1);
%             W = zeros(n);
%            
            alpha = zeros(3,n);
           K = RBFSpline.kernel_gaussian(source,source,sigma);
%            for ii = 1:n
%               W(ii,ii) = 1/(sigma(ii)^2); 
%            end
           q1 = target(:,1);
           q2 = target(:,2);
           q3 = target(:,3);
           
        %Ax = b, least squares problem: (K+lambda*W^-1)Alpha = q_k. x =
        %pinv(A)*b
          A = (K + lambda*eye(n));
%           
%           
          alpha(1,:) = pinv(A)*q1;
         
%         
          alpha(2,:) =pinv(A)*q2;
          
%          
          alpha(3,:) = pinv(A)*q3;
        
        end
        
        function [ux,uy,uz] = evaluate(x,y,z,control,alpha,sigma)
%             K = kernal_gaussian(x,control,sigma);
            x_sz = size(x);
            tot_points = numel(x);
            c_sz = size(control,1);
            
            ux = zeros(x_sz);
            uy = zeros(x_sz);
            uz = zeros(x_sz);
            r1 = zeros(1,c_sz);
            
            for ii = 1:tot_points
                point = [x(ii),y(ii),z(ii)];
                for jj = 1:c_sz
                 r1(1,jj) = norm(point - control(jj,:));
                end
                ux(ii) = x(ii) + sum(alpha(1,:) .* exp(-r1.^2/(2*sigma^2)));   
                uy(ii)= y(ii) + sum(alpha(2,:) .* exp(-r1.^2/(2*sigma^2)));
                uz(ii) = z(ii) + sum(alpha(3,:) .* exp(-r1.^2/(2*sigma^2)));
%                 u_x(ii,1) = x(ii,1) + sum(alpha(1,:) .* K(ii,:));
%                 u_y(ii,2) = y(ii,2) + sum(alpha(2,:) .* K(ii,:));
%                 u_z(ii,3) = z(ii,3) + sum(alpha(3,:) .* K(ii,:));
                
            end
            
        end
        
        function K = kernel_gaussian(x,control,sigma)
            
            q_sz = size(x); % source list of coords for each point 
            c_sz = size(control);
            m = q_sz(1);
            l = c_sz(1);
            K = zeros(l,m);
            for ii = 1:l
                for jj = 1:m
                    
            r1 = norm(x(ii,:) - control(jj,:));
            K(ii,jj) = exp(-r1^2/(2*sigma^2));
                end
            end
            
        end
    end
end

