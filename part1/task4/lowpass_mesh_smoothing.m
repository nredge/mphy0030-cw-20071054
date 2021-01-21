function smoothed = lowpass_mesh_smoothing(vertices,triangles,iterations,lambda,mu_ratio)

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

sz = size(vertices);
n = sz(1);
summ = zeros(1,3);
k = 6;
% omega = 1 / k;
dist = zeros(n,1);
% forward = zeros(642,3);
smoothed = zeros(642,3);

for ii = 1:iterations
    for jj = 1:n
        
    tri_ind = find(any(triangles==jj,2));
    tri = triangles(tri_ind,:);
    points = unique(tri);
    points(points == jj) = []; % removes point that is being transformed
    nn = numel(points); % number of neighbours

    neighbours = vertices(points,:);

    summation =  (1/nn)*(sum(neighbours(:,:) - vertices(jj,:)));
    
    vertices(jj,:) = vertices(jj,:) + lambda*summation;
%     end
%     for jj = 1:n
    summation =  (1/nn)*(sum(neighbours(:,:) - vertices(jj,:)));
    
    vertices(jj,:) = vertices(jj,:) + mu*summation;
    smoothed(jj,:) = vertices(jj,:);
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

    