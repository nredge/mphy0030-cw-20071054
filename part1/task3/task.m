a = randperm(10);
% a = a';
%
x = [2 2 2];
% x = x';

%%
quad = @(x,a) a(2)*x(1)^2 + a(3)*x(2)^2 + a(4)*x(3)^2 + a(5)*x(1)*x(2) + a(6)*x(1)*x(3)...
    + a(7)*x(2)*x(3) + a(8)*x(1) + a(9)*x(2) + a(10)*x(3) + a(1);

h = 0.001;
max_it = 1000;
tol = 0.01;
%
%grad = finite_difference_gradient(quad,x,a,h);
%
test = gradient_descent(quad,x,a,h,max_it,tol); 

final = quad(test,a);