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
        
        function coefficients = fit(obj,source,target,lambda,parameters)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
        function transformed = evaluate(obj,query,control,coeff,parameters)
            
        end
        
        function K = kernel_gaussian(obj,query,control,parameters)
            
        end
    end
end

