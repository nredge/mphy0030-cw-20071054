% load('data/example_vertices.csv');
% load('data/example_triangles.csv');

vertices = readmatrix('data/example_vertices.csv');
triangles = readmatrix('data/example_triangles.csv');

DT = delaunay(vertices);
%%
smoothed = lowpass_mesh_smoothing(vertices,DT);
% iterations,lamdba,mu_ratio);
%%
figure;
trimesh(triangles,vertices(:,1),vertices(:,2),vertices(:,3));
%%
figure;
trimesh(triangles,smoothed(:,1),smoothed(:,2),smoothed(:,3));