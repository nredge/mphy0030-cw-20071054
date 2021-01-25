clearvars;
x = zeros(10000,3); % intialise empty matrix to hold 10,000 vecotrs of x1 and x2
samples = size(x,1); % obtain number of individual vectors from x

x(:,1) = randn(samples,1); % generate 10,000 x1 samples from a standard normal distrubtion

% x(:,2) = randn(samples,1); % generate 10,000 x2 samples from a standard
% normal distrubtion, these are independent from x1, giving a circular
% distrubtion of x

x(:,2) = (x(:,1)-2) + ((x(:,1)+2)-(x(:,1)-2)).*rand(samples,1); 
% generate 10,000 x2 variables that are dependant on x1 so that each x2 is
% within a range of x1. This gives correlation and thus an elliptical
% distrubtion

% x(:,3) = randn(samples,1); % generate 10,000 x2 samples from a standard
% normal distrubtion, these are independent from x1, giving a circular
% distrubtion of x

x(:,3) = (x(:,1)-2) + ((x(:,1)+2)-(x(:,1)-2)).*rand(samples,1); 
% generate 10,000 x3 variables that are dependant on x1 so that each x3 is
% within a range of x1. This gives correlation and thus an elliptical
% distrubtion

meanVector = mean(x); % mean vector from 10,000 x samples
covariance = cov(x); % covariacne matrix from 10,000 x samples

pdf = gaussian_pdf(x,meanVector,covariance); % call pdf function to obtain 10,000 density values

%% I have found the percentile ellipsoids in to different ways. One uses values around the percentile to plot a mesh, but the result isn't a smooth ellipsoid
% The other method uses the eigenvalues and eigenvectors to create ellipsoids

ordered = sort(pdf(:)); % order all calculted pdf values from the bi_gaussian_pdf func from smallest to largest
index = numel(ordered); % count the number of pdf values

% to find percentiles, multiply each percentage by the total number of
% indexes and take the density value at that specific index
ninety_prc = ordered(0.9*index); % 90th percentile
fiftieth_prc = ordered(0.5*index); % 50th percentile
tenth_prc = ordered(0.1*index); % 10th percentile

% finds data values from pdf near to each percentile (as not enough values
% at each percentile)
ninety_points = find(pdf >= (ninety_prc - 0.001) & pdf <=(ninety_prc + 0.001));
fiftieth_points = find(pdf >= (fiftieth_prc - 0.001) & pdf <=(fiftieth_prc + 0.001));
tenth_points = find(pdf >= (tenth_prc - 0.001) & pdf <=(tenth_prc + 0.001));

% compute Delaunay triangulation of the points around each percentile
dt_90 = delaunay(x(ninety_points,1),x(ninety_points,2),x(ninety_points,3));
dt_50 = delaunay(x(fiftieth_points,1),x(fiftieth_points,2),x(fiftieth_points,3));
dt_10 = delaunay(x(tenth_points,1),x(tenth_points,2),x(tenth_points,3));

% using the Delaunay and the points, plot a trisurf for each of the
% percentiles. As can be seen, this doens't give proper ellipsoids.
% Therefore, I used another method below
figure;
trisurf(dt_90,x(ninety_points,1),x(ninety_points,2),x(ninety_points,3));
title('90th percentile');
xlim([-5 5]);
ylim([-5 5]);
zlim([-5 5]);

figure;
trisurf(dt_50,x(fiftieth_points,1),x(fiftieth_points,2),x(fiftieth_points,3));
title('50th percentile');
xlim([-5 5]);
ylim([-5 5]);
zlim([-5 5]);

figure;
trisurf(dt_10,x(tenth_points,1),x(tenth_points,2),x(tenth_points,3));
title('10th percentile');
xlim([-5 5]);
ylim([-5 5]);
zlim([-5 5]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Using eigenvectors and eigenvalues to plot ellipsoids
% Calculate eigenvectors and values of the covariance. Find the end points of the major
% and minor axes of the ellipsoid by:
%  mu += chiSquared(percentile)*sqrt(eigvalue)*eigvec. [mu = meanvector]
%90th percentile
[V,D] = eig(covariance);
ax90_1 = meanVector' + 2.5*sqrt(D(1,1))*V(:,1); 
ax90_2 = meanVector' - 2.5*sqrt(D(1,1))*V(:,1);

ax90_3 = meanVector' + 2.5*sqrt(D(2,2))*V(:,2); 
ax90_4 = meanVector' - 2.5*sqrt(D(2,2))*V(:,2); 

ax90_5 = meanVector' + 2.5*sqrt(D(3,3))*V(:,3);
ax90_6 = meanVector' - 2.5*sqrt(D(3,3))*V(:,3); 

% 50th percentile
ax50_1 = meanVector' + 1.538*sqrt(D(1,1))*V(:,1); 
ax50_2 = meanVector' - 1.538*sqrt(D(1,1))*V(:,1);

ax50_3 = meanVector' + 1.538*sqrt(D(2,2))*V(:,2); 
ax50_4 = meanVector' - 1.538*sqrt(D(2,2))*V(:,2); 

ax50_5 = meanVector' + 1.538*sqrt(D(3,3))*V(:,3);
ax50_6 = meanVector' - 1.538*sqrt(D(3,3))*V(:,3); 
% 10th percentile
ax10_1 = meanVector' + 0.764*sqrt(D(1,1))*V(:,1); 
ax10_2 = meanVector' - 0.764*sqrt(D(1,1))*V(:,1);

ax10_3 = meanVector' + 0.764*sqrt(D(2,2))*V(:,2); 
ax10_4 = meanVector' - 0.764*sqrt(D(2,2))*V(:,2); 

ax10_5 = meanVector' + 0.764*sqrt(D(3,3))*V(:,3);
ax10_6 = meanVector' - 0.764*sqrt(D(3,3))*V(:,3); 

% find the length of each semi-axis for each ellipsoid
ax90_1dist = norm(ax90_1 - ax90_2)/2;
ax90_2dist = norm(ax90_3 - ax90_4)/2;
ax90_3dist = norm(ax90_5 - ax90_6)/2;

ax50_1dist = norm(ax50_1 - ax50_2)/2;
ax50_2dist = norm(ax50_3 - ax50_4)/2;
ax50_3dist = norm(ax50_5 - ax50_6)/2;

ax10_1dist = norm(ax10_1 - ax10_2)/2;
ax10_2dist = norm(ax10_3 - ax10_4)/2;
ax10_3dist = norm(ax10_5 - ax10_6)/2;
 
% find the angle of each eigenvector to respective x,y,z axis
xangle = acosd(V(1,1)/norm(V(:,1)));
yangle = acosd(V(2,2)/norm(V(:,2)));
zangle = acosd(V(3,3)/norm(V(:,3)));

%% plot all three ellipsoid using meanVector, semi-axis lengths and then rotating
figure;
[X1, X2, X3] = ellipsoid(meanVector(1),meanVector(2),meanVector(3),ax90_1dist,ax90_2dist,ax90_3dist);
elip90 = surf(X1, X2, X3);
% rotate(elip90, [1 0 0], xangle);
rotate(elip90, [0 1 0], yangle);
rotate(elip90, [0 0 1], zangle);
title('90th percentile');
xlim([-5 5])
ylim([-5 5])
zlim([-5 5])
%
figure;
[X1, X2, X3] = ellipsoid(meanVector(1),meanVector(2),meanVector(3),ax50_1dist,ax50_2dist,ax50_3dist);
elip50 = surf(X1, X2, X3);
% rotate(elip50, [1 0 0], xangle);
rotate(elip50, [0 1 0], yangle);
rotate(elip50, [0 0 1], zangle);
title('50th percentile');
xlim([-5 5])
ylim([-5 5])
zlim([-5 5])
%
figure;
[X1, X2, X3] = ellipsoid(meanVector(1),meanVector(2),meanVector(3),ax10_1dist,ax10_2dist,ax10_3dist);
elip10 = surf(X1, X2, X3);
% rotate(elip10, [1 0 0], xangle);
rotate(elip10, [0 1 0], yangle);
rotate(elip10, [0 0 1], zangle);
title('10th percentile');
xlim([-5 5])
ylim([-5 5])
zlim([-5 5])