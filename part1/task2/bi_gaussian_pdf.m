function pdf = bi_gaussian_pdf(x,meanVector,cov)

%     inverse of diagonal matrix is reciprocal of diagonal entries
%     cov is diagonal matrix


pdf = 1 / (2 * pi * sqrt(det(cov))) * exp(-1/(2) * (x - meanVector) * inv(cov) * (x - meanVector)');

