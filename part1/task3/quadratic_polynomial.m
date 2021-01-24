% function that contains a multivariate polynomial with 3 variables, x1,
% x2, and x3, with highest order of 2. Parameter vector of a=[a0,...,a9]
function output = quadratic_polynomial(a,x)

output = a(2)*x(1)^2 + a(3)*x(2)^2 + a(4)*x(3)^2 + a(5)*x(1)*x(2) + a(6)*x(1)*x(3)...
    + a(7)*x(2)*x(3) + a(8)*x(1) + a(9)*x(2) + a(10)*x(3) + a(1);
% function outputs a scalar value which we are trying minimise in this
% task