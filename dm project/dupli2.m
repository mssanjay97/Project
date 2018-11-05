

numberofusers = 1200; 
numberofmovies=700;
userstars = zeros(1200, 1);

movie_list = cell(1200, 1);


for i=1:numberofusers
  userstars(i)=floor(rand(1)*5);
end
mm = fopen('movies.txt');
load('movieratings.mat');



for i = 1:numberofusers
    line=fgets(mm);
    [index, movie_name] = strtok(line, ' ');
    movie_list{i} = strtrim(movie_name);
end




predefineduserratingvalues=Y(1:1200,1:700);
predefineduserratingcheck=R(1:1200,1:700);
predefineduserratingvalues = [userstars predefineduserratingvalues];
predefineduserratingcheck = [(userstars ~= 0) predefineduserratingcheck];


[numberofmovies, numberofusers] = size(predefineduserratingvalues);
predefineduserratingvaluesmean = zeros(numberofmovies, 1);
predefineduserratingvaluesnorm = zeros(size(predefineduserratingvalues));
for i = 1:numberofmovies
    predefineduserratingvaluesmean(i) = mean(predefineduserratingvalues(i, predefineduserratingcheck(i, :)));
    predefineduserratingvaluesnorm(i, predefineduserratingcheck(i, :)) = predefineduserratingvalues(i, predefineduserratingcheck(i, :)) - predefineduserratingvaluesmean(i);
end


totalusers = size(predefineduserratingvalues, 2);
totalmovies = size(predefineduserratingvalues, 1);
totalfeatures = 7;


X = randn(totalmovies, totalfeatures);
Theta = randn(totalusers, totalfeatures);

initial_parameters = [X(:); Theta(:)];

%set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 200);

%set regularization
lambda = 5;
theta = findminx (@(t)(costfun(t, predefineduserratingvalues, predefineduserratingcheck, totalusers, totalmovies,totalfeatures, lambda)),initial_parameters, options);


X = reshape(theta(1:totalmovies*totalfeatures), totalmovies, totalfeatures);
Theta = reshape(theta(totalmovies*totalfeatures+1:end),totalusers, totalfeatures);


fprintf('ratings given by user:\n');
for i = 1:length(userstars)
    if userstars(i) > 0 
        fprintf('for the movie %s the user has given %d\n', movie_list{i},userstars(i));
    end
end

fprintf('finish recommender system learning \n');
fprintf(' movies that are recommended are \n');

%  recmnd
p = X * Theta';
my_predictions = p(:,1) + predefineduserratingvaluesmean;



[r, ix] = sort(my_predictions, 'descend');
for i=1:20
    j = ix(i);
    fprintf('recommended movie is %s with recommended ratings as %d\n',movie_list{j}, my_predictions(j));
end


