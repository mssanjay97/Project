fid = fopen('movies.txt');
userstars = zeros(1200, 1);

n = 1200; 

movie_list = cell(n, 1);


for i=1:n
  userstars(i)=floor(rand(1)*5);
end


for i = 1:n
    line=fgets(fid);
    [index, movie_name] = strtok(line, ' ');
    movie_list{i} = strtrim(movie_name);
end
fclose(fid);



fprintf('\n training data for collaborative filtering  \n');

load('movieratings.mat');


Y=Y(1:1200,:);
R=R(1:1200,:);
Y = [userstars Y];
R = [(userstars ~= 0) R];


[m, n] = size(Y);
Ymean = zeros(m, 1);
Ynorm = zeros(size(Y));
for i = 1:m
    Ymean(i) = mean(Y(i, R(i, :)));
    Ynorm(i, R(i, :)) = Y(i, R(i, :)) - Ymean(i);
end


totalusers = size(Y, 2);
totalmovies = size(Y, 1);
totalfeatures = 7;


X = randn(totalmovies, totalfeatures);
Theta = randn(totalusers, totalfeatures);

initial_parameters = [X(:); Theta(:)];

%set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 200);

%set regularization
lambda = 10;
theta = findminx (@(t)(costfun(t, Y, R, totalusers, totalmovies,totalfeatures, lambda)),initial_parameters, options);


X = reshape(theta(1:totalmovies*totalfeatures), totalmovies, totalfeatures);
Theta = reshape(theta(totalmovies*totalfeatures+1:end),totalusers, totalfeatures);


fprintf('ratings given by user:\n');
for i = 1:length(userstars)
    if userstars(i) > 0 
        fprintf('Rated %d for %s\n', userstars(i),movie_list{i});
    end
end

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


