function grad = finite_difference_gradient(x,a)

h = 0.001;
grad = zeros(1,3);
% x_h = x + h;
x1 = [x(1) + h, x(2), x(3)];
x2 = [x(1), x(2) + h, x(3)];
x3 = [x(1), x(2), x(3) + h];

% 
grad(1) = (quadratic_polynomial(a,x1) - quadratic_polynomial(a,x)) / h;

grad(2) = (quadratic_polynomial(a,x2) - quadratic_polynomial(a,x)) / h;

grad(3) = (quadratic_polynomial(a,x3) - quadratic_polynomial(a,x)) / h;

