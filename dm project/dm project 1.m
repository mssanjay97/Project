fid = fopen('movies.txt');
n = 1682;  % Total number of movies 
movie_list = cell(n, 1);
for i = 1:n
 
    line=fgets(fid);
    [index, movie_name] = strtok(line, ' ');
    movie_list{i} = strtrim(movie_name);
end
fclose(fid);


user_rating = zeros(1682, 1);
user_rating(434) = 4;
user_rating(983) = 2;
user_rating(57) = 3;
user_rating(22)= 5;
user_rating(394) = 4;
user_rating(684)= 5;
user_rating(766)= 3;
user_rating(569) = 5;
user_rating(383) = 4;
user_rating(926) = 5;
user_rating(955)= 5;

fprintf('\n\nnew user ratings:\n');
for i = 1:length(user_rating)
    if user_rating(i) > 0 
        fprintf('Rated %d for %s\n', user_rating(i), ...
                 movie_list{i});
    end
end

% train the collaborative filtering model on a movie rating dataset of 1682 movies and 943 users

fprintf('\n training data for collaborative filtering  \n');

load('movieratings.mat');

%  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies by 943 users
%  R is a 1682x943 matrix, where R(i,j) = 1 if and only if user j gave a rating to movie i

Y = [user_rating Y];
R = [(user_rating ~= 0) R];


[m, n] = size(Y);
Ymean = zeros(m, 1);
Ynorm = zeros(size(Y));
for i = 1:m
    Ymean(i) = mean(Y(i, R(i, :)));
    Ynorm(i, R(i, :)) = Y(i, R(i, :)) - Ymean(i);
end


num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;


X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

%set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

%set regularization
lambda = 10;
theta = findminx (@(t)(costfun(t, Y, R, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);


X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('finish recommender system learning \n');

%  recmnd
p = X * Theta';
my_predictions = p(:,1) + Ymean;



[r, ix] = sort(my_predictions, 'descend');
fprintf('\nTop recommendations :\n');
for i=1:20
    j = ix(i);
    fprintf('Predicting rating %.1f for movie %s\n', my_predictions(j), ...
            movie_list{j});
end


