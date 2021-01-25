clearvars;
a = randi(5,1,10); % generate a random 1x10 array of values a0-a9, with the values being between 1-5.

x = [1 1 1]; % generate an intial x vector of x1, x2, x3

%%
step_sz = 0.00001; % set step size, small size to avoid overshooting minimum
max_iter = 100000; % maximum number of iterations to run script
tol = 0.00001; % tolerance on the difference between two successive final function outputs

optimal_x = gradient_descent(x,a,step_sz,max_iter,tol); % call gradient_descent function to minimise the output of a multivariate polynomial iwth x & a
% the output is the x vector corresponding to the min function output

min_output = quadratic_polynomial(a,optimal_x); % uses the optimal x to obtain the minimised function output value

% verify output with first and second order derivative
grad = finite_difference_gradient(optimal_x,a); % a first derivative being close to zero symbolises a stationary point 
grad_2 = second_differivative(optimal_x,a); % a second order derivative being positive shows the stationary point is a minimum