function grad = finite_difference_gradient(polynomial,x,a,h)

grad = zeros(1,3);

grad(1) = (polynomial(x(1) - h,x(2),x(3),a) - polynomial(x(1),x(2),x(3),a)) / h;

grad(2) = (polynomial(x(1) - h,x(2),x(3),a) - polynomial(x(1),x(2),x(3),a)) / h;

grad(3) = (polynomial(x(1) - h,x(2),x(3),a) - polynomial(x(1),x(2),x(3),a)) / h;

