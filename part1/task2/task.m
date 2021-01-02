
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

% figure;
% surf(X1,X2,interp_pdf);

%% 50th percentile

alpha = 0.5;
ellipse1 = zeros(3,1);
idx = 1;
% 
for ii = 1:100
   for jj = 1:100
    c = ([x1lin(ii),x2lin(jj)] - meanVector) * inv(covariance) * ([x1lin(ii),x2lin(jj)] - meanVector)';
    if abs(c - (-2*log(alpha))) <= 0.001
        ellipse1(idx) = interp_pdf(ii,jj);
        idx = idx +1;
    else
        ;
    end
   end
end

alpha = 0.9;
ellipse2 = zeros(3,1);
idx = 1;

for ii = 1:100
   for jj = 1:100
    c = ([x1lin(ii),x2lin(jj)] - meanVector) * inv(covariance) * ([x1lin(ii),x2lin(jj)] - meanVector)';
    if abs(c - (-2*log(alpha))) <= 0.001
        ellipse2(idx) = interp_pdf(ii,jj);
        idx = idx +1;
    else
        ;
    end
   end
end

alpha = 0.1;
ellipse3 = zeros(3,1);
idx = 1;

for ii = 1:100
   for jj = 1:100
    c = ([x1lin(ii),x2lin(jj)] - meanVector) * inv(covariance) * ([x1lin(ii),x2lin(jj)] - meanVector)';
    if abs(c - (-2*log(alpha))) <= 0.01
        ellipse3(idx) = interp_pdf(ii,jj);
        idx = idx +1;
    else
        ;
    end
   end
end


%% 
contour_height1 = mean(ellipse1);
contour_height2 = mean(ellipse2);
contour_height3 = mean(ellipse3);

figure;
surf(X1,X2,interp_pdf);
hold on
[M1,c1] =contour3(X1,X2,interp_pdf,[contour_height1 contour_height1],'r');
c1.LineWidth = 2;
hold on
[M2,c2] =contour3(X1,X2,interp_pdf,[contour_height2 contour_height2],'c');
c2.LineWidth = 2;
hold on
[M3,c3] =contour3(X1,X2,interp_pdf,[contour_height3 contour_height3],'m');
c3.LineWidth = 2;
