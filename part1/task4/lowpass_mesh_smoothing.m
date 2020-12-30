function smooth = lowpass_mesh_smoothing(vertices,triangles,varargin,iterations,lambda,mu)

if length(varargin) == 0
    iterations = 10;
    lambda = 0.9;
    mu = -1.02 * lambda;
elseif length(varargin) == 1
    lambda = 0.9;
    mu = -1.02 * lambda;
elseif length(varargin) == 2
     mu = -1.02 * lambda;
else
    ;
end
gjg
