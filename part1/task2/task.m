% two equal size sets: x1 and x2 i.e
% x1 = 1:100;
% x2 = 1:100;


x = zeros(10000,2);
sz = size(x);
samples = sz(1);

for ii = 1:samples
    x(ii,1) = randi(100);
    x(ii,2) = randi(100);
end

meanVector = mean(x);
covariance = cov(x);

pdf = bi_gaussian_pdf(x,meanVector,covariance);


%%
% 10th percentile

