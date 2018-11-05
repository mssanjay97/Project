function [cost,val] = costfun(params)

cost = 0;
lambda=2;
num_features=18;
num_users=1200; 
num_movies=700
moviemat = reshape(params(1:num_movies*num_features), num_movies, num_features);
usermat = reshape(params(num_movies*num_features+1:end),num_users, num_features);
       

moviediff = randn(size(moviemat));
userdiff = randn(size(usermat));

val = [moviediff(:); userdiff(:)];

end
