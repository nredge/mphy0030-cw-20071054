% function that approxiamtes the partial derivatives of the quadratic for
% x1, x2, and x3. The vector of these derivatives gives an approx gradient
% at x
function grad = finite_difference_gradient(x,a)

h = 0.001; % step size used for the finite difference scheme
grad = zeros(1,3); % intiliase empty array to store the 3 partial derivatives
% x_h = x + h;

x1 = [x(1) + h, x(2), x(3)]; % create three new x vectors, where each has one of x1, x2 or x3 increased by a small amount, h
x2 = [x(1), x(2) + h, x(3)]; % this is required to implement the finite difference scheme
x3 = [x(1), x(2), x(3) + h];

% forward finite difference shcemes to approx the partial derivaitve of each variable
% scheme is given by df(x)/dx = (f(x+h)-f(x)) / h
grad(1) = (quadratic_polynomial(a,x1) - quadratic_polynomial(a,x)) / h; 
                                                                        
grad(2) = (quadratic_polynomial(a,x2) - quadratic_polynomial(a,x)) / h;

grad(3) = (quadratic_polynomial(a,x3) - quadratic_polynomial(a,x)) / h;

