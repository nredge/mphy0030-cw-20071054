function pdf = bi_gaussian_pdf(x,meanVector,covariance)

sz = size(x);

pdf = zeros(10000,1);

for ii = 1:sz(1)
    pdf(ii,1) = 1 / (2 * pi * sqrt(det(covariance))) * exp(-1/(2) * (x(ii,:) - meanVector) * inv(covariance) * (x(ii,:) - meanVector)');
end
