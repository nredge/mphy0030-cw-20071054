function smoothed = lowpass_mesh_smoothing(vertices,triangles,iterations,lambda,mu_ratio)

if nargin == 2
    iterations = 10;
    lambda = 0.9;
    mu = -1.02 * lambda;
elseif nargin == 3
    lambda = 0.9;
    mu = -1.02 * lambda;
elseif nargin == 4
     mu = -1.02 * lambda;
else
   mu = mu_ratio * lambda;
end

sz = size(vertices);
n = sz(1);
 omega = 1 / n;

for ii = 1:iterations
    
    vertices = vertices + lambda * omega * (dsearchn(vertices,triangles,vertices) - vertices);
    vertices = vertices + mu * omega * (dsearchn(vertices,triangles,vertices) - vertices);
    
end

smoothed = vertices;