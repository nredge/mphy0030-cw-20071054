% two equal size sets: x1 and x2 i.e
% x1 = 1:100;
% x2 = 1:100;
clear;

x = zeros(10000,2);
sz = size(x);
samples = sz(1);

for ii = 1:samples
    x(ii,1) = randi(100);
    x(ii,2) = randi(100);
end

meanVector = mean(x,1);

cov = zeros(2,2);

for ii = 1:samples
    cov(1,1) = cov(1,1) + (x(ii,1) - meanVector(1))*(x(ii,1) - meanVector(1));
    cov(1,2) = cov(1,2) + (x(ii,1) - meanVector(1))*(x(ii,2) - meanVector(2));
    cov(2,1) = cov(2,1) + (x(ii,2) - meanVector(2))*(x(ii,1) - meanVector(1));
    cov(2,2) = cov(2,2) + (x(ii,2) - meanVector(2))*(x(ii,2) - meanVector(2));
end

cov = cov / samples;
pdf = bi_gaussian_pdf(x,meanVector,cov);