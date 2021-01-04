% function to generate probability density values from a given set of
% x=[x1,x2,x3] vectores, the mean vector and a covariance matrix
function pdf = gaussian_pdf(x,meanVector,covariance)

sz = size(x); % obtain size of set of x vectors

pdf = zeros(10000,1); % intialise an empty matrix to store pdf values

for ii = 1:sz(1)
    pdf(ii,1) = 1 / ((2 * pi)^(3/2) * sqrt(det(covariance))) * exp(-1/(2) * (x(ii,:) - meanVector) * inv(covariance) * (x(ii,:) - meanVector)');
end
% loop across all rows of x, as each x is a vecotr of one set of x1, x2 & x3.
% Implement each vector along with mean and covariance to generate density
% value that each individual x vector