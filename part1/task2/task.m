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

%
x1lin = linspace(min(x(:,1)),max(x(:,1)),100);
x2lin = linspace(min(x(:,2)),max(x(:,2)),100);

[X1,X2] = meshgrid(x1lin,x2lin);

f = scatteredInterpolant(x(:,1),x(:,2),pdf);
interp_pdf = f(X1,X2);

figure;
surf(X1,X2,interp_pdf);

%% 50th percentile
% ellipse = zeros(10,3);
% idx = 1;
% fun = @(X1,X2) f(X1,X2);
% for ii = 1:100
%     for jj = 1:100
%         q = integral2(fun,x1lin(1),x1lin(ii),x2lin(1),x2lin(jj));
%         if q == 0.5
%             ellipse(idx,1) = x1lin(ii);
%             ellipse(idx,2) = x2lin(jj);
%             ellipse(idx,3) = interp_pdf(ii,jj);
%             idx = idx +1;
%         end
%     end
% end

alpha = 0.5;
ellipse = zeros(10,3);
idx = 1;
% 
for ii = 1:100
   for jj = 1:100
    c = ([x1lin(ii),x2lin(jj)] - meanVector) * inv(covariance) * ([x1lin(ii),x2lin(jj)] - meanVector)';
    if abs(c - (-2*log(alpha))) <= 0.1
        ellipse(idx,1) = x1lin(ii);
        ellipse(idx,2) = x2lin(jj);
        ellipse(idx,3) = interp_pdf(ii,jj);
        idx = idx +1;
    else
        ;
    end
   end
end

figure;
plot3(ellipse(:,1),ellipse(:,2),ellipse(:,3));
% hold on
% mesh(X1,X2,interp_pdf);