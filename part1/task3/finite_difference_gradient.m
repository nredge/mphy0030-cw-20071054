function grad = finite_difference_gradient(x,a)

grad = zeros(1,3);
% 
% grad(1) = (polynomial(x(1) - h,x(2),x(3),a) - polynomial(x(1),x(2),x(3),a)) / h;
% 
% grad(2) = (polynomial(x(1) - h,x(2),x(3),a) - polynomial(x(1),x(2),x(3),a)) / h;
% 
% grad(3) = (polynomial(x(1) - h,x(2),x(3),a) - polynomial(x(1),x(2),x(3),a)) / h;


grad(1) = a(2)*2*x(1) + a(5)*x(2) + a(6)*x(3) + a(8); % partial derivative in x1

grad(2) = a(3)*2*x(2) + a(5)*x(1) + a(7)*x(3) + a(9); % partial derivative in x2

grad(3) = a(4)*2*x(3)  + a(6)*x(1) + a(7)*x(2) + a(10); % partial derivative in x3