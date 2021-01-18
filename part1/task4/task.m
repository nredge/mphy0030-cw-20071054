% load('data/example_vertices.csv');
% load('data/example_triangles.csv');

vertices = readmatrix('data/example_vertices.csv');
triangles = readmatrix('data/example_triangles.csv');

iterations = [5 10 25];
% smoothed = lowpass_mesh_smoothing(vertices,triangles,5);%,10,0.9,-1.02);
%
figure;
for ii = 1:size(iterations,2)
  
    smoothed = lowpass_mesh_smoothing(vertices,triangles,iterations(ii));
    
    subplot(2,2,ii);
    trimesh(triangles,smoothed(:,1),smoothed(:,2),smoothed(:,3));
%     trimesh(triangles,vertices(:,1),vertices(:,2),vertices(:,3));
end
% figure;
% trimesh(triangles,smoothed(:,1),smoothed(:,2),smoothed(:,3));