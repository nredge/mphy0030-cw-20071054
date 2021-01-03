
x = zeros(10000,2); % intialise empty matrix to hold 10,000 vecotrs of x1 and x2
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

meanVector = mean(x); % mean vector from 10,000 x samples
covariance = cov(x); % covariacne matrix from 10,000 x samples

pdf = bi_gaussian_pdf(x,meanVector,covariance); % call pdf function to obtain 10,000 density values
%% to plot a surface or mesh, the pdf values must be a matrix. To obtain this,
% scattered interpolant was used with x and the pdf values to generate a
% interpolant function, f
f = scatteredInterpolant(x(:,1),x(:,2),pdf); % this function allows a matrix of pdf values to be generated for any given grid of x1 and x2 

x1lin = linspace(min(x(:,1)),max(x(:,1)),100); % create an array on 100 values from the minimal of all x1 values to the maximum of x1 values
x2lin = linspace(min(x(:,2)),max(x(:,2)),100); % create an array on 100 values from the minimal of all x2 values to the maximum of x2 values

[X1,X2] = meshgrid(x1lin,x2lin); % create a meshgrid using the above spacings

interp_pdf = f(X1,X2); % using the meshgrid, generate a 100x100 matrix of interpolated pdf values. Surf/mesh functions can now be used

interp_pdf = max(interp_pdf,0); % set negative interpolated density values to zero
%%
ordered = sort(pdf(:)); % order all calculted pdf values from the bi_gaussian_pdf func from smallest to largest
index = numel(ordered); % count the number of pdf values

% to find percentiles, multiply each percentage by the total number of
% indexes and take the density value at that specific index
ninety_prc = ordered(0.9*index); % 90th percentile
fiftieth_prc = ordered(0.5*index); % 50th percentile
tenth_prc = ordered(0.1*index); % 10th percentile

% the bivariate gaussian pdf is plotted with each of the three percentiles
% displayed as contours. If x1 and x2 are independent, the distrubtion
% is circular. If x1 and x2 are correlated, the distrubtrion is elliptical
figure;
surf(X1,X2,interp_pdf); % surface plot using the meshgrid and interpolated values
hold on
[M,c] =contour3(X1,X2,interp_pdf,[ninety_prc ninety_prc],'r'); % creates a red contour at the 90th percentile value
c.LineWidth = 2;
hold on
[M2,c2] =contour3(X1,X2,interp_pdf,[fiftieth_prc fiftieth_prc],'m'); % creates a magenta contour at the 50th percentile value
c2.LineWidth = 2;
hold on
[M3,c3] =contour3(X1,X2,interp_pdf,[tenth_prc tenth_prc],'c'); % creates a cyan contour at the 10th percentile value
c3.LineWidth = 2;
hold off
% all contour line widths are set to 2 for better visualisation 