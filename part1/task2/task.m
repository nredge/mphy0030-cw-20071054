clear;
x = zeros(10000,3); % intialise empty matrix to hold 10,000 vecotrs of x1 and x2
sz = size(x); % obtain size of x
samples = sz(1); % obtain number of individual vectors from x

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
%% to plot a surface or mesh, the pdf values must be a matrix. To obtain this,
% scattered interpolant was used with x and the pdf values to generate a
% interpolant function, f
% f = scatteredInterpolant(x(:,1),x(:,2),x(:,3),pdf); % this function allows a matrix of pdf values to be generated for any given grid of x1 and x2 

% x1lin = linspace(min(x(:,1)),max(x(:,1)),100); % create an array on 100 values from the minimal of all x1 values to the maximum of x1 values
% x2lin = linspace(min(x(:,2)),max(x(:,2)),100); % create an array on 100 values from the minimal of all x2 values to the maximum of x2 values
% x3lin = linspace(min(x(:,3)),max(x(:,2)),100);
% 
% [X1,X2,X3] = meshgrid(x1lin,x2lin,x3lin); % create a meshgrid using the above spacings
% 
% interp_pdf = f(X1,X2,X3); % using the meshgrid, generate a 100x100 matrix of interpolated pdf values. Surf/mesh functions can now be used
% 
% interp_pdf = max(interp_pdf,0); % set negative interpolated density values to zero
%%
% figure;
% plot3(x(:,1),x(:,2),x(:,3),'x');

%%
ordered = sort(pdf(:)); % order all calculted pdf values from the bi_gaussian_pdf func from smallest to largest
index = numel(ordered); % count the number of pdf values

% to find percentiles, multiply each percentage by the total number of
% indexes and take the density value at that specific index
ninety_prc = ordered(0.9*index); % 90th percentile
fiftieth_prc = ordered(0.5*index); % 50th percentile
tenth_prc = ordered(0.1*index); % 10th percentile
%% 
% ninetyvec = find(interp_pdf >= (ninety_prc - 0.01) & interp_pdf <=(ninety_prc + 0.01));
% ninetyvec = find(pdf >= (ninety_prc - 0.001) & pdf <=(ninety_prc + 0.001));
% [i1 i2 i3] = ind2sub([100 100 100],ninetyvec);
%%
% figure;
% plot3(x(ninetyvec,1),x(ninetyvec,2),x(ninetyvec,3),'x');


%%
% dt = delaunay(x(ninetyvec,1),x(ninetyvec,2),x(ninetyvec,3));
% figure;
% trisurf(dt,x(ninetyvec,1),x(ninetyvec,2),x(ninetyvec,3));
% xlim([-5 5])
% ylim([-5 5])
% zlim([-5 5])
%% 90th percentile
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


ax90_1dist = norm(ax90_1 - ax90_2)/2;
ax90_2dist = norm(ax90_3 - ax90_4)/2;
ax90_3dist = norm(ax90_5 - ax90_6)/2;

ax50_1dist = norm(ax50_1 - ax50_2)/2;
ax50_2dist = norm(ax50_3 - ax50_4)/2;
ax50_3dist = norm(ax50_5 - ax50_6)/2;

ax10_1dist = norm(ax10_1 - ax10_2)/2;
ax10_2dist = norm(ax10_3 - ax10_4)/2;
ax10_3dist = norm(ax10_5 - ax10_6)/2;
% 
%% 
xangle = acosd(V(1,1)/norm(V(:,1)));
yangle = acosd(V(2,2)/norm(V(:,2)));
zangle = acosd(V(3,3)/norm(V(:,3)));

%%
figure;
% subplot(3,1,1);
[X1, X2, X3] = ellipsoid(meanVector(1),meanVector(2),meanVector(3),ax90_1dist,ax90_2dist,ax90_3dist);
elip90 = surf(X1, X2, X3);
rotate(elip90, [1 0 0], xangle);
rotate(elip90, [0 1 0], yangle);
rotate(elip90, [0 0 1], zangle);
xlim([-5 5])
ylim([-5 5])
zlim([-5 5])
%
figure;
% subplot(3,1,2);
[X1, X2, X3] = ellipsoid(meanVector(1),meanVector(2),meanVector(3),ax50_1dist,ax50_2dist,ax50_3dist);
elip50 = surf(X1, X2, X3);
rotate(elip50, [1 0 0], xangle);
rotate(elip50, [0 1 0], yangle);
rotate(elip50, [0 0 1], zangle);
xlim([-5 5])
ylim([-5 5])
zlim([-5 5])
%
figure;
% subplot(3,1,3);
[X1, X2, X3] = ellipsoid(meanVector(1),meanVector(2),meanVector(3),ax10_1dist,ax10_2dist,ax10_3dist);
elip10 = surf(X1, X2, X3);
rotate(elip10, [1 0 0], xangle);
rotate(elip10, [0 1 0], yangle);
rotate(elip10, [0 0 1], zangle);
xlim([-5 5])
ylim([-5 5])
zlim([-5 5])