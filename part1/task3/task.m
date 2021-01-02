a = randperm(10);
% a = a';
%
x = [2 2 2];
% x = x';

%%
% quad = @(x,a) a(2)*x(1)^2 + a(3)*x(2)^2 + a(4)*x(3)^2 + a(5)*x(1)*x(2) + a(6)*x(1)*x(3)...
%     + a(7)*x(2)*x(3) + a(8)*x(1) + a(9)*x(2) + a(10)*x(3) + a(1);

% quad = @(x1,x2,x3,a) a(2)*x1^2 + a(3)*x2^2 + a(4)*x3^2 + a(5)*x1*x2 + a(6)*x1*x3...
%     + a(7)*x2*x3 + a(8)*x1 + a(9)*x2 + a(10)*x3 + a(1);
%%
step_sz = 0.00001;
max_iter = 10000;
tol = 0.001;
%
%grad = finite_difference_gradient(quad,x,a,h);
%
test = gradient_descent(x,a,step_sz,max_iter,tol); 

final = quadratic_polynomial(a,test);