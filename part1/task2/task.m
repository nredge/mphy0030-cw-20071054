% two equal size sets: x1 and x2 i.e
% x1 = 1:100;
% x2 = 1:100;

x = zeros(10000,2);
sz = size(x);
samples = sz(1);

x(:,1) = randn(samples,1);
x(:,2) = randn(samples,1);

meanVector = mean(x);
covariance = cov(x);

pdf = bi_gaussian_pdf(x,meanVector,covariance);

%%
x1lin = linspace(min(x(:,1)),max(x(:,1)),100);
x2lin = linspace(min(x(:,2)),max(x(:,2)),100);

[X1,X2] = meshgrid(x1lin,x2lin);

f = scatteredInterpolant(x(:,1),x(:,2),pdf);
interp_pdf = f(X1,X2);

figure;
surf(X1,X2,interp_pdf);

%% 10th percentile
% fun = @(x1,x2) f(x1,x2);
% q = integral2(fun,min(x(:,1)),max(x(:,1)),min(x(:,2)),max(x(:,2)));

alpha = 0.9;
elipse = (x