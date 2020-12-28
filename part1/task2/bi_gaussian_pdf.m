function prob = bi_gaussian_pdf(x1,x2,mean_vec,covar_mat)

x = [x1,x2];
prob = 1 / (2 * pi sqrt(det(covar_mat))) * exp(-1/(2) * (x - mean_vec).' * covar_mat^(-1) * (x - mean_vec));

end