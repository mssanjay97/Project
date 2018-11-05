movieList = loadMovieList();
my_ratings = zeros(1682, 1);
my_ratings(1) = 4;
my_ratings(98) = 2;
my_ratings(17) = 3;
my_ratings(92)= 5;
my_ratings(94) = 4;
my_ratings(84)= 5;
my_ratings(166)= 3;
my_ratings(269) = 5;
my_ratings(783) = 4;
my_ratings(226) = 5;
my_ratings(355)= 5;

fprintf('\n\nnew user ratings:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 movieList{i});
    end
end

% train the collaborative filtering model on a movie rating dataset of 1682 movies and 943 users

fprintf('\n training data for collaborative filtering -social project \n');

load('ex8_movies.mat');

%  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies by 943 users
%  R is a 1682x943 matrix, where R(i,j) = 1 if and only if user j gave a rating to movie i

Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];

% normalisation
[Ynorm, Ymean] = normalizeRatings(Y, R);


num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;

%initialise parameters theta and x
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

%set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

%set regularization
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Y, R, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);


X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('finish recommender system learning \n');

%  recmnd
p = X * Theta';
my_predictions = p(:,1) + Ymean;

movieList = loadMovieList();

[r, ix] = sort(my_predictions, 'descend');
fprintf('\nTop recommendations for you:\n');
for i=1:20
    j = ix(i);
    fprintf('Predicting rating %.1f for movie %s\n', my_predictions(j), ...
            movieList{j});
end

fprintf('\n\nOriginal ratings provided:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 movieList{i});
    end
end

