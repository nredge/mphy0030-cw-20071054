a = randi(5,1,10);
% a = a';
%
x = [2 2 2];
% x = x';

%%

%%
step_sz = 0.00001;
max_iter = 100000;
tol = 0.0001;
%
%grad = finite_difference_gradient(quad,x,a,h);
%
test = gradient_descent(x,a,step_sz,max_iter,tol); 

final = quadratic_polynomial(a,test);

% verify second order derivative
grad = finite_difference_gradient(test,a);
grad_2 = second_differivative(test,a);