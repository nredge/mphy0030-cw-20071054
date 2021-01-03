% function that approximates second order partial derivatives using the
% forward finite difference scheme, to help verify the final x vector
function grad_2 = second_differivative(x,a)

h = 0.001; % step size used for the finite difference scheme
grad_2 = zeros(1,3); % intiliase empty array to store the 3 partial derivatives

x1_h = [x(1) + h, x(2), x(3)]; % create three new x vectors, where each has one of x1, x2 or x3 increased by a small amount, h
x2_h = [x(1), x(2) + h, x(3)];
x3_h = [x(1), x(2), x(3) + h];

x1_2h = [x(1) + 2*h, x(2), x(3)]; % create three new x vectors, where each has one of x1, x2 or x3 increased by 2*h
x2_2h = [x(1), x(2) + 2*h, x(3)];
x3_2h = [x(1), x(2), x(3) + 2*h];

% forward finite difference shcemes to approx the second order partial derivaitves of each variable
% scheme is given by d^2 f(x)/dx^2 = (f(x+2*h)-2*f(x+h)+f(x)) / h^2
grad_2(1) = (quadratic_polynomial(a,x1_2h) - 2*quadratic_polynomial(a,x1_h) + quadratic_polynomial(a,x)) / h^2;

grad_2(2) = (quadratic_polynomial(a,x2_2h) - 2*quadratic_polynomial(a,x2_h) + quadratic_polynomial(a,x)) / h^2;

grad_2(3) = (quadratic_polynomial(a,x3_2h) - 2*quadratic_polynomial(a,x3_h) + quadratic_polynomial(a,x)) / h^2;