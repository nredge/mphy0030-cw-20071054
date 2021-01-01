a = randperm(10);
a = a';
%
x = [10 10 10];
x = x';

%%
quad = @(x1,x2,x3,a) a(2)*x1^2 + a(3)*x2^2 + a(4)*x3^2 + a(5)*x1*x2 + a(6)*x1*x3...
    + a(7)*x2*x3 + a(8)*x1 + a(9)*x2 + a(10)*x3 + a(1);

h = 0.01;
max_it = 100;
tol = 0.1;
%
grad = finite_difference_gradient(quad,x,a,h);
%% 
gradient_descent(quad,x,a,h,max_it,tol,grad); 