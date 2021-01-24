% load('data/example_vertices.csv');
% load('data/example_triangles.csv');

% loads in the vertices and triangles csv files as matrices
vertices = readmatrix('data/example_vertices.csv');
triangles = readmatrix('data/example_triangles.csv');


% set 3 different iteration amounts to loop through
iterations = [5 10 25];

% open a figure and plot the original strucutre with no smoothing. 
% All iterations will be displayed as subplots.
figure;
subplot(2,2,1)
trimesh(triangles,vertices(:,1),vertices(:,2),vertices(:,3));
title('No smoothing');

% The loop runs through each element in iterations per run, creating 3
% different smoothings
for ii = 1:length(iterations)
  
    smoothed = lowpass_mesh_smoothing(vertices,triangles,iterations(ii)); % calls smoothing function with iteration specified by loops run
    % default paramters are used for lambda=0.9 and mu=-1.02*lambda.
    % Default iterations is 10 is none is specified
    
    % plots each iteration run in the figure as a subplot
    subplot(2,2,(ii+1));
    trimesh(triangles,smoothed(:,1),smoothed(:,2),smoothed(:,3));
    title(sprintf('Smoothing after %i iterations',iterations(ii)));
end

