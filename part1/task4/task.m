% load('data/example_vertices.csv');
% load('data/example_triangles.csv');

vertices = readmatrix('data/example_vertices.csv');
triangles = readmatrix('data/example_triangles.csv');



%%
iterations = [5 10 25];
% smoothed = lowpass_mesh_smoothing(vertices,triangles,25);%,10,0.9,-1.02);
str = string(iterations); 
figure;
for ii = 1:size(iterations,2)
  
    smoothed = lowpass_mesh_smoothing(vertices,triangles,iterations(ii));
    
    subplot(2,2,1)
    trimesh(triangles,vertices(:,1),vertices(:,2),vertices(:,3));
    title('No smoothing');
    
    subplot(2,2,(ii+1));
    trimesh(triangles,smoothed(:,1),smoothed(:,2),smoothed(:,3));
    title(sprintf('Smoothing after %i iterations',iterations(ii)));
end

% figure;
% trimesh(triangles,vertices(:,1),vertices(:,2),vertices(:,3));
% figure;
% trimesh(triangles,smoothed(:,1),smoothed(:,2),smoothed(:,3));