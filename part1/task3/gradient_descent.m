function optimal = gradient_descent(x, a, step_sz, max_iter, tol)
iter = 1;
delta = 1;

while iter <= max_iter && delta >= tol
grad = finite_difference_gradient(x,a);
% grad_norm = norm(grad);

newx = x - step_sz * grad;

delta = quadratic_polynomial(a,x) - quadratic_polynomial(a,newx); 

x = newx;

iter = iter + 1;

end
optimal = x;