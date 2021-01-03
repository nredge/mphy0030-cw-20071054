function grad_2 = second_differivative(x,a)

h = 0.001;
grad_2 = zeros(1,3);

x1_h = [x(1) + h, x(2), x(3)];
x2_h = [x(1), x(2) + h, x(3)];
x3_h = [x(1), x(2), x(3) + h];

x1_2h = [x(1) + 2*h, x(2), x(3)];
x2_2h = [x(1), x(2) + 2*h, x(3)];
x3_2h = [x(1), x(2), x(3) + 2*h];

% 
grad_2(1) = (quadratic_polynomial(a,x1_2h) - 2*quadratic_polynomial(a,x1_h) + quadratic_polynomial(a,x)) / h^2;

grad_2(2) = (quadratic_polynomial(a,x2_2h) - 2*quadratic_polynomial(a,x2_h) + quadratic_polynomial(a,x)) / h^2;

grad_2(3) = (quadratic_polynomial(a,x3_2h) - 2*quadratic_polynomial(a,x3_h) + quadratic_polynomial(a,x)) / h^2;