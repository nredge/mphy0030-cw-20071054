% gradient descent function that uses a given intial x vector, a parameters,
% step size, max iterations, and tolerance, to minimise the output of the
% quadratic polynomial and return the corresponding x vector
function optimal = gradient_descent(x, a, step_sz, max_iter, tol)

iter = 1; % sets initial iteration number to be 1
delta = 1; % sets initial delta to be 1 i.e greater than tolerance

while iter <= max_iter && delta >= tol % loop that allows function to run until either max iterations is reached, or delta is smaller than the tolerance

grad = finite_difference_gradient(x,a); % calls finite diff grad function to obtain partial derivatives of the quadratic for x1, x2, and x3
% this gives an estimation of the gradient at x

newx = x - step_sz * grad; % obtains a new x vector by subtracting (step size * gradient) from current x vector. Subtraction is used as want to move away from ascent

delta = quadratic_polynomial(a,x) - quadratic_polynomial(a,newx); % finds the difference in output values of the quadratic between current x and new x

x = newx; % updates x to new x

iter = iter + 1; % updates iteration number by 1

end
optimal = x; % returns final x vector that gives minimised f(x)