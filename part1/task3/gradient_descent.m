function optimal = gradient_descent(quad, x, a, h, max_it, tol)
it = 1;
delta = 1;
while it <= max_it && delta >= tol
grad = finite_difference_gradient(x,a);
% grad_norm = norm(grad);

newx = x - h * grad;

delta = quad(x,a) - quad (newx,a); 

x = newx;

it = it + 1;

end
optimal = x;