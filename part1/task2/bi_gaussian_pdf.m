function pdf = bi_gaussian_pdf(x,meanVector,covariance)

pdf = 1 / (2 * pi * sqrt(det(covariance))) * exp(-1/(2) * (x - meanVector) * inv(covariance) * (x - meanVector)');

