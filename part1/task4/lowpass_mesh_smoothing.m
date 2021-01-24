function smoothed = lowpass_mesh_smoothing(vertices,triangles,iterations,lambda,mu_ratio)

% set default paramaters for iterations, lambda, and mu based on how many
% input arguments have been entered
if nargin == 2
    iterations = 10;
    lambda = 0.9;
    mu = -1.02 * lambda;
elseif nargin == 3
    lambda = 0.9;
    mu = -1.02 * lambda;
elseif nargin == 4
     mu = -1.02 * lambda;
else
   mu = mu_ratio * lambda;
end

n = size(vertices,1); % number of vertices


smoothed = zeros(642,3); %initalise empty array to store smoothed vertices

for ii = 1:iterations %loop for number of iterations
    for jj = 1:n % loop for each vertex
        
    tri_index = find(any(triangles==jj,2)); % finds all the indices for the triangles (rows in triangles data) that contain the vertex to be transformed  
    tri = triangles(tri_index,:); % uses the indices to obtain the triangles containing the vertex. This provides the neighbouring vertices indices as well
    points = unique(tri); % neighbouring vertices will be repeated in the triangles so this removes repeats
    points(points == jj) = []; % removes vertex that is being transformed so its not included as a neighbour: final list of indices of vertices
    num_neighbours = numel(points); % number of neighbours 
    omega = 1 / num_neighbours; % weighting factor

    neighbours = vertices(points,:); % uses neighbour indices to find coordiantes of neighbours from vertices list

    summation =  omega*(sum(neighbours - vertices(jj,:))); % computer sum of differences between each neighbour and vertex to be transformed & multiply by weighting factor
    
    vertices(jj,:) = vertices(jj,:) + lambda*summation; % multiply sum by optimisation paramter for 'forward' transform and add onto vertex's original coordinates
    
    summation =  omega*(sum(neighbours - vertices(jj,:))); % repeat sum but new vertex position
    
    vertices(jj,:) = vertices(jj,:) + mu*summation; % multiply sum now by mu parameter for 'step-back' transform
    smoothed(jj,:) = vertices(jj,:); % save new position into smoothed matrix
    end
end
    
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for ii = 1:iterations
%     
%     for jj = 1:n
%         
%         for kk = 1:n
%         dist(kk,:) = norm(vertices(kk,:) - vertices(jj,:)); 
%         end
%         
%         [d,ind] = sort(dist);
%         ind_closest = ind(2:k+1);
%         vertices_closest =  vertices(ind_closest,:);
%         
%         for ll = 1:k
%             summ = summ + (1/k)*(vertices_closest(ll,:) - vertices(jj,:));
%         end
%         
%         vertices(jj,:) = vertices(jj,:) + lambda * summ; 
%         summ(:,:) = 0;
%     end 
%    
%     for jj = 1:n
%         
%         for kk = 1:n 
%             dist(kk,:) = norm(vertices(kk,:) - vertices(jj,:));
%         end
%         
%         [d,ind] = sort(dist); 
%         ind_closest = ind(2:k+1); 
%         vertices_closest =  vertices(ind_closest,:);
%         
%         for ll = 1:k
%             summ = summ + (1/k)*(vertices_closest(ll,:) - vertices(jj,:));
%         end
%         
%         vertices(jj,:) = vertices(jj,:) + mu *  summ; 
%         smoothed(jj,:) = vertices(jj,:);
%           summ(:,:) = 0;
%     end
% end

    